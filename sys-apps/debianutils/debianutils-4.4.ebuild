# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils flag-o-matic

DESCRIPTION="A selection of tools from Debian"
HOMEPAGE="http://packages.qa.debian.org/d/debianutils.html"
SRC_URI="mirror://debian/pool/main/d/${PN}/${PN}_${PV}.tar.gz"

LICENSE="BSD GPL-2 SMAIL"
SLOT="0"
KEYWORDS="amd64"
IUSE="kernel_linux static"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.4.2-no-bs-namespace.patch
}

src_configure() {
	use static && append-ldflags -static
	default
}

src_install() {
	into /
	dobin tempfile run-parts
	if use kernel_linux ; then
		dosbin installkernel
	fi

	into /usr
	dosbin savelog

	doman tempfile.1 run-parts.8 savelog.8
	use kernel_linux && doman installkernel.8
	cd debian
	dodoc changelog control
	keepdir /etc/kernel/postinst.d
}
