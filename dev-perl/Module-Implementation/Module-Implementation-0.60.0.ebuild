# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=0.06
inherit perl-module

DESCRIPTION="Loads one of several alternate underlying implementations for a module"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="test"

RDEPEND="
	>=dev-perl/Module-Runtime-0.12.0
	dev-perl/Try-Tiny
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.300.0
	test? (
		dev-perl/Test-Requires
		dev-perl/Test-Fatal
		>=virtual/perl-Test-Simple-0.880.0
	)
"

SRC_TEST=do
