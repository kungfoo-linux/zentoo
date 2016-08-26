# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64"

IUSE=""
RDEPEND="
	~perl-core/${PN#perl-}-${PV}
	!=perl-core/File-Temp-0.230.400
"

# this is the dev-lang/perl-5.20 and dev-lang/perl-5.22 and dev-lang/perl-5.24 version but we need the security patch
