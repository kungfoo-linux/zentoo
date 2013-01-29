# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

WANT_AUTOCONF="2.5"

inherit eutils flag-o-matic toolchain-funcs pam autotools user

DESCRIPTION="Full-screen window manager that multiplexes physical terminals between several processes"
HOMEPAGE="http://www.gnu.org/software/screen/"
SRC_URI="ftp://ftp.uni-erlangen.de/pub/utilities/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="debug nethack pam selinux multiuser"

RDEPEND=">=sys-libs/ncurses-5.2
	pam? ( virtual/pam )
	selinux? ( sec-policy/selinux-screen )"
DEPEND="${RDEPEND}"

pkg_setup() {
	# Make sure utmp group exists, as it's used later on.
	enewgroup utmp 406
}

src_prepare() {
	# Bug 34599: integer overflow in 4.0.1
	# (Nov 29 2003 -solar)
	epatch "${FILESDIR}"/screen-4.0.1-int-overflow-fix.patch

	# Bug 31070: configure problem which affects alpha
	# (13 Jan 2004 agriffis)
	epatch "${FILESDIR}"/screen-4.0.1-vsprintf.patch

	# uclibc doesnt have sys/stropts.h
	if ! (echo '#include <sys/stropts.h>' | $(tc-getCC) -E - &>/dev/null) ; then
		epatch "${FILESDIR}"/4.0.2-no-pty.patch
	fi

	# Don't use utempter even if it is found on the system
	epatch "${FILESDIR}"/4.0.2-no-utempter.patch

	# Don't link against libelf even if it is found on the system
	epatch "${FILESDIR}"/4.0.2-no-libelf.patch

	# Patch for time function on 64bit systems
	epatch "${FILESDIR}"/4.0.2-64bit-time.patch

	# Patch that makes %u work for windowlist -b formats
	epatch "${FILESDIR}"/4.0.2-windowlist-multiuser-fix.patch

	# Open tty in non-blocking mode
	epatch "${FILESDIR}"/4.0.2-nonblock.patch

	# compability for sys-devel/autoconf-2.62
	epatch "${FILESDIR}"/screen-4.0.3-config.h-autoconf-2.62.patch

	# crosscompile patch
	epatch "${FILESDIR}"/"${P}"-crosscompile.patch

	# sched.h is a system header and causes problems with some C libraries
	mv sched.h _sched.h || die
	sed -i '/include/s:sched.h:_sched.h:' screen.h || die

	# Allow for more rendition (color/attribute) changes in status bars
	sed -i \
		-e "s:#define MAX_WINMSG_REND 16:#define MAX_WINMSG_REND 64:" \
		screen.c \
		|| die "sed screen.c failed"

	# Fix manpage.
	sed -i \
		-e "s:/usr/local/etc/screenrc:${EPREFIX}/etc/screenrc:g" \
		-e "s:/usr/local/screens:${EPREFIX}/var/run/screen:g" \
		-e "s:/local/etc/screenrc:${EPREFIX}/etc/screenrc:g" \
		-e "s:/etc/utmp:${EPREFIX}/var/run/utmp:g" \
		-e "s:/local/screens/S-:${EPREFIX}/var/run/screen/S-:g" \
		doc/screen.1 \
		|| die "sed doc/screen.1 failed"

	# proper setenv detection for Solaris
	epatch "${FILESDIR}"/${P}-setenv_autoconf.patch

	# Allow TERM string large enough to use with rxvt-unicode-256color
	# Allow usernames up to 32 chars
	epatch "${FILESDIR}"/${PV}-extend-d_termname-ng2.patch

	# reconfigure
	eautoconf
}

src_configure() {
	append-flags "-DMAXWIN=${MAX_SCREEN_WINDOWS:-100}"

	[[ ${CHOST} == *-solaris* ]] && append-libs -lsocket -lnsl

	use nethack || append-flags "-DNONETHACK"
	use debug && append-flags "-DDEBUG"

	econf \
		--with-socket-dir="${EPREFIX}/var/run/screen" \
		--with-sys-screenrc="${EPREFIX}/etc/screenrc" \
		--with-pty-mode=0620 \
		--with-pty-group=5 \
		--enable-rxvt_osc \
		--enable-telnet \
		--enable-colors256 \
		$(use_enable pam) \
		$(use multiuser || echo --disable-socket-dir)

	# Second try to fix bug 12683, this time without changing term.h
	# The last try seemed to break screen at run-time.
	# (16 Jan 2003 agriffis)
	LC_ALL=POSIX make term.h || die "Failed making term.h"
}

src_install() {
	dobin screen

	if use multiuser || use prefix
	then
		fperms 4755 /usr/bin/screen
	else
		fowners root:utmp /usr/bin/screen
		fperms 2755 /usr/bin/screen
	fi

	insinto /usr/share/screen
	doins terminfo/{screencap,screeninfo.src}
	insinto /usr/share/screen/utf8encodings
	doins utf8encodings/??
	insinto /etc
	doins "${FILESDIR}"/screenrc

	pamd_mimic_system screen auth

	dodoc \
		README ChangeLog INSTALL TODO NEWS* patchlevel.h \
		doc/{FAQ,README.DOTSCREEN,fdpat.ps,window_to_display.ps}

	doman doc/screen.1
	doinfo doc/screen.info*
}

pkg_postinst() {
	elog "Some dangerous key bindings have been removed or changed to more safe values."
	elog "We enable some xterm hacks in our default screenrc, which might break some"
	elog "applications. Please check /etc/screenrc for information on these changes."
}