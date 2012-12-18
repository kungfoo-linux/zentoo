# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MODULE_AUTHOR=SFINK
MODULE_VERSION=1.07
inherit perl-module

DESCRIPTION="Human-readable unit-aware calculator"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="virtual/perl-Time-Local"
RDEPEND="${DEPEND}"

SRC_TEST=do
