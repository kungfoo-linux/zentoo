# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4,5} pypy pypy3  )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

DESCRIPTION="Distribution utilities"
HOMEPAGE="https://pypi.python.org/pypi/distlib https://bitbucket.org/vinay.sajip/distlib https://github.com/vsajip/distlib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

SLOT="0"
LICENSE="BSD"
KEYWORDS="amd64"
IUSE=""

DEPEND="app-arch/unzip"

python_test() {
	sed \
		-e '/PIP_AVAILABLE/s:True:False:g' \
		-i tests/*py || die
	PYTHONHASHSEED=0 esetup.py test
}
