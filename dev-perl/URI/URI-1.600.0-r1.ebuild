# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=GAAS
MODULE_VERSION=1.60
inherit perl-module

DESCRIPTION="A URI Perl Module"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="virtual/perl-MIME-Base64"
RDEPEND="${DEPEND}"

SRC_TEST=no # see ChangeLog

mydoc="rfc2396.txt"
