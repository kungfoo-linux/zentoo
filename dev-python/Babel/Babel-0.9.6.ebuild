# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit eutils distutils

DESCRIPTION="A collection of tools for internationalizing Python applications"
HOMEPAGE="http://babel.edgewall.org/ http://pypi.python.org/pypi/Babel"
SRC_URI="http://ftp.edgewall.com/pub/babel/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-python/pytz
	dev-python/setuptools"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="babel"

src_prepare() {
	epatch "${FILESDIR}"/${P}-setuptools.patch
	distutils_src_prepare
}

src_install() {
	distutils_src_install
	dohtml -r doc/* || die "dohtml failed"
}
