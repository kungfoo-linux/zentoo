# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Virtual for the C library"
SLOT="0"
KEYWORDS="amd64"

# explicitly depend on SLOT 2.2 of glibc, because it sets
# a different SLOT for cross-compiling
RDEPEND="!prefix? (
		elibc_glibc? ( sys-libs/glibc:2.2 )
		elibc_musl? ( sys-libs/musl )
		elibc_uclibc? ( || ( sys-libs/uclibc sys-libs/uclibc-ng ) )
		elibc_FreeBSD? ( sys-freebsd/freebsd-lib )
	)"
