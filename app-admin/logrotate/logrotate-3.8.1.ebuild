# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Rotates, compresses, and mails system logs"
HOMEPAGE="https://fedorahosted.org/logrotate/"
SRC_URI="https://fedorahosted.org/releases/l/o/logrotate/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="acl selinux"

RDEPEND="
	>=dev-libs/popt-1.5
	selinux? (
		sys-libs/libselinux
		sec-policy/selinux-logrotate
	)
	acl? ( virtual/acl )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_prepare() {
	strip-flags

	epatch \
		"${FILESDIR}"/${PN}-3.7.7-datehack.patch \
		"${FILESDIR}"/${PN}-3.8.0-ignore-hidden.patch \
		"${FILESDIR}"/${PN}-3.8.0-fbsd.patch \
		"${FILESDIR}"/${PN}-3.8.0-atomic-create.patch \
		"${FILESDIR}"/${PN}-3.8.1-noasprintf.patch
}

src_configure() {
	return
}

src_compile() {
	local myconf
	myconf="CC=$(tc-getCC)"
	use selinux && myconf="${myconf} WITH_SELINUX=yes"
	use acl && myconf="${myconf} WITH_ACL=yes"
	emake ${myconf} RPM_OPT_FLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	insinto /usr
	dosbin logrotate
	doman logrotate.8
	dodoc CHANGES examples/logrotate*

	exeinto /etc/cron.daily
	doexe "${FILESDIR}"/logrotate.cron

	insinto /etc
	doins "${FILESDIR}"/logrotate.conf

	keepdir /etc/logrotate.d
}

pkg_postinst() {
	elog "If you wish to have logrotate e-mail you updates, please"
	elog "emerge virtual/mailx and configure logrotate in"
	elog "/etc/logrotate.conf appropriately"
	elog
	elog "Additionally, /etc/logrotate.conf may need to be modified"
	elog "for your particular needs.  See man logrotate for details."
}