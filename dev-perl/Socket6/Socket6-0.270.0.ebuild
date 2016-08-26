# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=UMEMOTO
MODULE_VERSION=0.27
inherit perl-module

DESCRIPTION="IPv6 related part of the C socket.h defines and structure manipulators"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

SRC_TEST="do"

src_unpack() {
	perl-module_src_unpack
	tc-export CC
}
