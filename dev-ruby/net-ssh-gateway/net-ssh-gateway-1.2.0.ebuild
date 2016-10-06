# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
USE_RUBY="ruby22"

inherit ruby-fakegem

DESCRIPTION="A simple library to assist in enabling tunneled Net::SSH connections"
HOMEPAGE="http://net-ssh.rubyforge.org/gateway"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="amd64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/net-ssh-2.6.5"
