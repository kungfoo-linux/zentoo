# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils

DESCRIPTION="GNU macro processor"
HOMEPAGE="https://www.gnu.org/software/m4/m4.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="examples"

# remember: cannot dep on autoconf since it needs us
DEPEND="app-arch/xz-utils"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-fix-test-readlink.patch #376639
	epatch "${FILESDIR}"/${P}-no-gets.patch #424978

	# Disable gnulib build test that has no impact on the source.
	echo 'exit 0' > tests/test-update-copyright.sh || die
}

src_configure() {
	# Disable automagic dependency over libsigsegv; see bug #278026
	export ac_cv_libsigsegv=no

	local myconf=""
	[[ ${USERLAND} != "GNU" ]] && myconf="--program-prefix=g"
	econf --enable-changeword ${myconf}
}

src_test() {
	[[ -d /none ]] && die "m4 tests will fail with /none/" #244396
	emake check || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	# autoconf-2.60 for instance, first checks gm4, then m4.  If we don't have
	# gm4, it might find gm4 from outside the prefix on for instance Darwin
	use prefix && dosym /usr/bin/m4 /usr/bin/gm4
	dodoc BACKLOG ChangeLog NEWS README* THANKS TODO
	if use examples ; then
		docinto examples
		dodoc examples/*
		rm -f "${ED}"/usr/share/doc/${PF}/examples/Makefile*
	fi
}
