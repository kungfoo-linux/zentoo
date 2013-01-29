# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="Nagios-rb is a compact framework for writing Nagios plugins"
HOMEPAGE="https://github.com/jcsalterego/nagios-rb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""