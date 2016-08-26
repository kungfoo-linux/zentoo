# Copyright 1999-2016 Gentoo Foundation
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
	!<dev-perl/Test-Tester-0.114.0
	!<dev-perl/Test-use-ok-0.160.0
"
