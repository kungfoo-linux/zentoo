# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

DIST_AUTHOR=ETHER
DIST_VERSION=1.71
inherit perl-module

DESCRIPTION="Uniform Resource Identifiers (absolute and relative)"

SLOT="0"
KEYWORDS="amd64"
IUSE="test"

RDEPEND="
	>=virtual/perl-Exporter-5.570.0
	>=virtual/perl-MIME-Base64-2
	virtual/perl-Scalar-List-Utils
	virtual/perl-parent
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? (
		virtual/perl-File-Temp
		>=virtual/perl-Test-Simple-0.960.0
	)
"
