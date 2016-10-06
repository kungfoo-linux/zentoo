# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=GAAS
MODULE_VERSION=3.71
inherit perl-module

DESCRIPTION="Parse <HEAD> section of HTML documents"

SLOT="0"
KEYWORDS="amd64"
IUSE="test"

RDEPEND=">=dev-perl/HTML-Tagset-3.03"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST=do
mydoc="ANNOUNCEMENT"
