# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} pypy{1_8,1_9} )

inherit distutils-r1

DESCRIPTION="Remove outdated built kernels"
HOMEPAGE="https://bitbucket.org/mgorny/eclean-kernel/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="kernel_linux? ( dev-python/pymountboot[${PYTHON_USEDEP}] )"
