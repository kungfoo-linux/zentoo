# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit flag-o-matic

DESCRIPTION="The GNU info program and utilities"
HOMEPAGE="https://www.gnu.org/software/texinfo/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="nls static"

RDEPEND="!=app-text/tetex-2*
	>=sys-libs/ncurses-5.2-r2
	dev-lang/perl
	dev-perl/libintl-perl
	dev-perl/Unicode-EastAsianWidth
	dev-perl/Text-Unidecode
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	nls? ( sys-devel/gettext )"

src_configure() {
	use static && append-ldflags -static
	econf \
		--with-external-libintl-perl \
		--with-external-Unicode-EastAsianWidth \
		--with-external-Text-Unidecode \
		$(use_enable nls)
}

src_install() {
	default
	newdoc info/README README.info
}
