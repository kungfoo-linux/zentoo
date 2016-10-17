# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby22"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_GEMSPEC=${PN}.gemspec

inherit ruby-fakegem user

DESCRIPTION="Chef is a systems integration framework"
HOMEPAGE="http://wiki.opscode.com/display/chef"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

# specs have various indempotency issues which result in the global Chef::Config
# object to be replaced and subsequently fails other specs. Revisit this later.
RESTRICT="test"

ruby_add_rdepend "
	~dev-ruby/chef-config-${PV}
	>=dev-ruby/chef-zero-4.5
	>=dev-ruby/diff-lcs-1.2.4
	>=dev-ruby/diff-lcs-1.2.4
	>=dev-ruby/erubis-2.7
	>=dev-ruby/ffi-yajl-2.2
	>=dev-ruby/highline-1.6.9
	>=dev-ruby/mixlib-authentication-1.4
	>=dev-ruby/mixlib-cli-1.4
	>=dev-ruby/mixlib-log-1.3
	>=dev-ruby/mixlib-shellout-2.0
	>=dev-ruby/net-sftp-2.1.2
	>=dev-ruby/net-ssh-2.9
	>=dev-ruby/net-ssh-multi-1.1
	>=dev-ruby/ohai-8.6.0
	>=dev-ruby/proxifier-1.0
	>=dev-ruby/syslog-logger-1.6
	>=dev-ruby/uuidtools-2.1.5
	dev-ruby/ruby-shadow
	dev-ruby/open4
"

each_ruby_prepare() {
	ruby_fakegem_metadata_gemspec ../metadata ${RUBY_FAKEGEM_GEMSPEC}

	# so much crap we don't need
	sed -i -e '/require.*plist/d' lib/chef/provider/launchd.rb || die "Unable to fix up dependencies."
	sed -i -e '/require.*plist/d' lib/chef/provider/user/dscl.rb || die "Unable to fix up dependencies."
	sed -i -e '/plist/d' ${RUBY_FAKEGEM_GEMSPEC} || die "Unable to fix up dependencies."
	sed -i -e '/rspec/d' ${RUBY_FAKEGEM_GEMSPEC} || die "Unable to fix up dependencies."
	sed -i -e '/serverspec/d' ${RUBY_FAKEGEM_GEMSPEC} || die "Unable to fix up dependencies."
	sed -i -e '/specinfra/d' ${RUBY_FAKEGEM_GEMSPEC} || die "Unable to fix up dependencies."
	sed -i -e '/bundler/d' ${RUBY_FAKEGEM_GEMSPEC} || die "Unable to fix up dependencies."
}

all_ruby_install() {
	all_fakegem_install

	keepdir /etc/chef /var/lib/chef /var/log/chef

	insinto /etc/chef
	doins "${FILESDIR}/client.rb"
	doins "${FILESDIR}/solo.rb"

	doman distro/common/man/man1/*.1
	doman distro/common/man/man8/*.8
}

pkg_setup() {
	enewgroup chef
	enewuser chef -1 -1 /var/lib/chef chef
}
