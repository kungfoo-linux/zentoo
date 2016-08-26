# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit xorg-2

EGIT_REPO_URI="git://anongit.freedesktop.org/xorg/font/util"
DESCRIPTION="X.Org font utilities"

KEYWORDS="amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

XORG_CONFIGURE_OPTIONS="--with-mapdir=${EPREFIX}/usr/share/fonts/util --with-fontrootdir=${EPREFIX}/usr/share/fonts"
