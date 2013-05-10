# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MODULE_AUTHOR=GBARR
MODULE_VERSION=2.16
inherit perl-module

DESCRIPTION="A Perl SASL interface"

SLOT="0"
KEYWORDS="amd64"
IUSE="kerberos"

DEPEND="dev-perl/Digest-HMAC
	kerberos? ( dev-perl/GSSAPI )"
RDEPEND="${DEPEND}"

SRC_TEST="do"
export OPTIMIZE="$CFLAGS"
