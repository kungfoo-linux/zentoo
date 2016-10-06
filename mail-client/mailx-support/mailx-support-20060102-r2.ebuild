# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils toolchain-funcs

DESCRIPTION="Provides lockspool utility"
HOMEPAGE="http://www.openbsd.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND=""
DEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-respect-ldflags.patch
	epatch "${FILESDIR}"/${P}-add-sys_file_h.patch

	# This code should only be ran with Gentoo Prefix profiles
	if use prefix; then
		ebegin "Allowing unprivileged install"
		sed -i -e "s|-g 0 -o 0||g" Makefile
		eend $?
	fi
}

src_compile() {
	emake CC="$(tc-getCC)" BINDNOW_FLAGS="" || die "emake failed"
}

src_install() {
	emake prefix="${D}/usr" install
}
