# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
# jruby → has shims for Java handling but tests fail badly, remaining
# stuck; avoid that for now.
USE_RUBY="ruby18 ree18 ruby19"

RUBY_FAKEGEM_DOCDIR="rdoc"

inherit ruby-fakegem

DESCRIPTION="EventMachine is a fast, simple event-processing library for Ruby programs."
HOMEPAGE="http://rubyeventmachine.com"

LICENSE="|| ( GPL-2 Ruby )"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="${DEPEND}
	dev-libs/openssl"
RDEPEND="${RDEPEND}
	dev-libs/openssl"

each_ruby_configure() {
	for extdir in ext ext/fastfilereader; do
		pushd $extdir
		${RUBY} extconf.rb || die "extconf.rb failed for ${extdir}"
		popd
	done
}

each_ruby_compile() {
	for extdir in ext ext/fastfilereader; do
		pushd $extdir
		# both extensions use C++, so use the CXXFLAGS not the CFLAGS
		emake CFLAGS="${CXXFLAGS} -fPIC" archflag="${LDFLAGS}" || die "emake failed for ${extdir}"
		popd
		cp $extdir/*.so lib/ || die "Unable to copy extensions for ${extdir}"
	done
}

each_ruby_test() {
	${RUBY} -Ilib -S testrb tests/test_*.rb || die
}

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}/
	doins -r examples || die "Failed to install examples"
}