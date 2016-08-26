# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby22"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem
SRC_URI="https://github.com/floehopper/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

DESCRIPTION="Adds a __metaclass__ method to all Ruby objects"
HOMEPAGE="https://github.com/floehopper/metaclass"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

all_ruby_prepare() {
	sed -i -e '/bundler/ s:^:#:' Rakefile test/test_helper.rb || die
}
