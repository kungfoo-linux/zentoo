# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="TODO README.textile"

inherit ruby-fakegem

ruby_add_bdepend "doc? ( dev-ruby/yard )"
# redcloth is also needed to build documentation, but not available for
# jruby. Since we build documentation with the main ruby implementation
# only we skip the dependency for jruby in this roundabout way, assuming
# that jruby won't be the main ruby.
USE_RUBY="${USE_RUBY/jruby/}" ruby_add_bdepend "doc? ( dev-ruby/redcloth )"

DESCRIPTION="An improved version of the Test::Unit framework from Ruby 1.8"
HOMEPAGE="http://test-unit.rubyforge.org/"

LICENSE="Ruby"
SLOT="2"
KEYWORDS="amd64"
IUSE="doc test"

all_ruby_compile() {
	all_fakegem_compile

	if use doc; then
		yard doc --title ${PN} || die
	fi
}

each_ruby_test() {
	# the rake audit using dev-ruby/zentest currently fails, and we
	# just need to call the testsuite directly.
	# rake audit || die "rake audit failed"
	local rubyflags

	[[ ${RUBY} == */jruby ]] && rubyflags="-X+O"

	${RUBY} ${rubyflags} test/run-test.rb || die "testsuite failed"
}

all_ruby_install() {
	all_fakegem_install

	newbin "${FILESDIR}"/testrb testrb-2
}