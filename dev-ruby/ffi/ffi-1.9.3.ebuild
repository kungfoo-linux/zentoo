# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# jruby → unneeded, this is part of the standard JRuby distribution, and
# would just install a dummy.
USE_RUBY="ruby18 ruby19 ruby20"

RUBY_FAKEGEM_TASK_TEST="specs"

RUBY_FAKEGEM_TASK_DOC="doc:yard"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Ruby extension for programmatically loading dynamic libraries"
HOMEPAGE="http://wiki.github.com/ffi/ffi"

SRC_URI="http://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${PN}-git-${PV}.tgz"

IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

RDEPEND+=" virtual/libffi"
DEPEND+=" virtual/libffi"

ruby_add_bdepend "dev-ruby/rake-compiler dev-ruby/yard
	test? ( dev-ruby/rspec:2 )"

ruby_add_rdepend "virtual/ruby-threads"

all_ruby_prepare() {
	sed -i -e '/tasks/ s:^:#:' \
		-e '/Gem::Tasks/,/end/ s:^:#:' Rakefile || die
}

each_ruby_compile() {
	${RUBY} -S rake compile || die "compile failed"
	${RUBY} -S rake -f gen/Rakefile || die "types.conf generation failed"
}

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc samples/*
}