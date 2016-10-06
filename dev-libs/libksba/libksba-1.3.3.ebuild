# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

# so we won't need to autoreconf yet another g10 package
AUTOTOOLS_IN_SOURCE_BUILD=1
inherit autotools-utils

DESCRIPTION="X.509 and CMS (PKCS#7) library"
HOMEPAGE="http://www.gnupg.org/related_software/libksba"
SRC_URI="mirror://gnupg/libksba/${P}.tar.bz2"

LICENSE="LGPL-3+ GPL-2+ GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="static-libs"

RDEPEND=">=dev-libs/libgpg-error-1.8"
DEPEND="${RDEPEND}"
