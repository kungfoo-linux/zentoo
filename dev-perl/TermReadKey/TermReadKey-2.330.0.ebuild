# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=JSTOWE
MODULE_VERSION=2.33
inherit perl-module

DESCRIPTION="Change terminal modes, and perform non-blocking reads"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="virtual/perl-ExtUtils-MakeMaker"

SRC_TEST="do parallel"
