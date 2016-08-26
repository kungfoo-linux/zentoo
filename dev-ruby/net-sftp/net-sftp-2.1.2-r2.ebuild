# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby22"

RUBY_FAKEGEM_EXTRADOC="CHANGES.txt README.rdoc"

inherit ruby-fakegem

DESCRIPTION="SFTP in pure Ruby"
HOMEPAGE="https://github.com/net-ssh/net-sftp"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="amd64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/net-ssh-2.6.5"

ruby_add_bdepend "
	test? (
		>=dev-ruby/mocha-0.13
	)"
