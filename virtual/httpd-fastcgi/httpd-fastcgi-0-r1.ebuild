# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Virtual for FastCGI-enabled webservers"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="|| (
	www-apache/mod_fcgid
	www-servers/lighttpd
	www-servers/bozohttpd
	www-servers/nginx
	www-servers/resin
	www-servers/cherokee
	)"
DEPEND=""
