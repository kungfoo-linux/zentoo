# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
USE_RUBY="ruby18 ruby19 jruby ree18"

RUBY_FAKEGEM_TASK_DOC="doc:yard"
RUBY_FAKEGEM_RECIPE_TEST="rspec"

RAKE_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.md CHANGELOG.md"

RUBY_FAKEGEM_EXTRAINSTALL="data"

inherit ruby-fakegem

DESCRIPTION="A replacement for the URI implementation that is part of Ruby's standard library."
HOMEPAGE="http://addressable.rubyforge.org/"

LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="amd64"
IUSE="doc test"

ruby_add_bdepend "doc? ( dev-ruby/yard )"
ruby_add_bdepend "test? ( dev-ruby/rspec:2 )"

all_ruby_prepare() {
	# Remove spec-related tasks so that we don't need to require rspec
	# just to build the documentation, bug 383611.
	sed -i -e '/spectask/d' Rakefile || die
	rm tasks/rspec.rake || die
}
