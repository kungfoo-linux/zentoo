# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT_REAL=(
	# actual targets
	python{2_5,2_6,3_1}
)
PYTHON_COMPAT=(
	${PYTHON_COMPAT_REAL[@]}
	# these versions provide built-in argparse
	# but we still list them to warn user to migrate
	python{2_7,3_2}
)

inherit distutils-r1

DESCRIPTION="An easy, declarative interface for creating command line tools"
HOMEPAGE="http://code.google.com/p/argparse/ http://pypi.python.org/pypi/argparse"
SRC_URI="http://argparse.googlecode.com/files/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

pkg_pretend() {
	local x
	for x in ${PYTHON_COMPAT_REAL[@]}; do
		if use python_targets_${x}; then
			return
		fi
	done

	ewarn 'You have installed this version of argparse only for Python'
	ewarn 'implementations which provide the argparse module already.'
	ewarn 'Most likely, this means that something in your system depends on'
	ewarn 'dev-python/argparse instead of virtual/python-argparse.'
	ewarn
	ewarn 'Please try running the following command or an equivalent one:'
	ewarn
	ewarn '	emerge --verbose --depclean dev-python/argparse'
	ewarn
	ewarn 'If your package manager refuses to uninstall the package due to'
	ewarn 'unsatisfied dependencies, please first try re-installing the listed'
	ewarn 'packages and running --depclean again. If that does not help, please'
	ewarn 'report a bug against the package, requesting its maintainer to fix'
	ewarn 'the dependency on argparse to use virtual/argparse.'
}

python_test() {
	COLUMNS=80 PYTHONPATH="${BUILD_DIR}/lib" \
		"${PYTHON}" test/test_argparse.py
}
