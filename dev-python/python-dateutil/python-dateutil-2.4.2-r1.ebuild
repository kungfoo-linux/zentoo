# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4,5} pypy pypy3 )

inherit distutils-r1

DESCRIPTION="Extensions to the standard Python datetime module"
HOMEPAGE="
	https://dateutil.readthedocs.org/
	https://pypi.python.org/pypi/python-dateutil
	https://github.com/dateutil/dateutil/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
	>=dev-python/six-1.5[${PYTHON_USEDEP}]
	sys-libs/timezone-data"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

PATCHES=(
	"${FILESDIR}"/${P}-timelex.patch
)

_python_prepare_all() {
	# don't install zoneinfo tarball
	sed -i '/package_data=/d' setup.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	esetup.py test
}
