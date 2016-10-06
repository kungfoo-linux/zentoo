# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=GAAS
MODULE_VERSION=6.02
inherit perl-module

DESCRIPTION="Parse /robots.txt file"

SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	!<dev-perl/libwww-perl-6
	>=dev-perl/URI-1.10
"
DEPEND="${RDEPEND}"

SRC_TEST=online
