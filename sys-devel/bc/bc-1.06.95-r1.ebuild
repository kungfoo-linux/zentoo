# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Handy console-based calculator utility"
HOMEPAGE="https://www.gnu.org/software/bc/bc.html"
SRC_URI="mirror://gnu-alpha/bc/${P}.tar.bz2
	mirror://gnu/bc/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE="libedit readline static"

RDEPEND="readline? ( >=sys-libs/readline-4.1 >=sys-libs/ncurses-5.2 )
	libedit? ( dev-libs/libedit )"
DEPEND="${RDEPEND}
	sys-devel/flex"

src_prepare() {
	epatch "${FILESDIR}"/${P}-void_uninitialized.patch #349339
}

src_configure() {
	local myconf
	if use readline ; then
		myconf="--with-readline --without-libedit"
	elif use libedit ; then
		myconf="--without-readline --with-libedit"
	else
		myconf="--without-readline --without-libedit"
	fi
	use static && append-ldflags -static
	econf ${myconf}

	# Do not regen docs -- configure produces a small fragment that includes
	# the version info which causes all pages to regen (newer file). #554774
	touch -r doc doc/*
}

src_compile() {
	emake AR="$(tc-getAR)" || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS FAQ NEWS README ChangeLog
}
