# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MODULE_AUTHOR=GRANTM
MODULE_VERSION=2.18
inherit perl-module

DESCRIPTION="XML::Simple - Easy API to read/write XML (esp config files)"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="virtual/perl-Storable
	dev-perl/XML-SAX
	dev-perl/XML-LibXML
	>=dev-perl/XML-NamespaceSupport-1.04
	>=dev-perl/XML-Parser-2.30"
DEPEND="${RDEPEND}"

SRC_TEST="do"