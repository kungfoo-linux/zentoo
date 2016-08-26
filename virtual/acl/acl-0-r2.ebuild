# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit multilib-build

DESCRIPTION="Virtual for acl support (sys/acl.h)"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="static-libs"

DEPEND=""
RDEPEND="kernel_linux? ( >=sys-apps/acl-2.2.52-r1[static-libs?,${MULTILIB_USEDEP}] )
	kernel_FreeBSD? ( >=sys-freebsd/freebsd-lib-9.1-r10[${MULTILIB_USEDEP}] )"
