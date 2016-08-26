# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=SHLOMIF
MODULE_VERSION=0.17024
inherit perl-module

DESCRIPTION="Error/exception handling in an OO-ish way"

LICENSE+=" MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="test"

RDEPEND="
	virtual/perl-Scalar-List-Utils
"
DEPEND="${RDEPEND}
	>=dev-perl/Module-Build-0.280.801
	test? (
		virtual/perl-Test-Simple
	)
"

SRC_TEST="do parallel"

src_test() {
	perl_rm_files t/pod-coverage.t t/pod.t
	perl-module_src_test
}
