# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MODULE_AUTHOR=NWCLARK
MODULE_VERSION=0.18
inherit perl-module

DESCRIPTION="PerlIO::Gzip - PerlIO layer to gzip/gunzip"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

SRC_TEST="do"
