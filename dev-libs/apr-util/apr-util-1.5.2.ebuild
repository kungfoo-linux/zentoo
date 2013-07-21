# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

# Usually apr-util has the same PV as apr, but in case of security fixes, this may change.
# APR_PV="${PV}"
APR_PV="1.4.6"

inherit autotools db-use eutils libtool multilib

DESCRIPTION="Apache Portable Runtime Utility Library"
HOMEPAGE="http://apr.apache.org/"
SRC_URI="mirror://apache/apr/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="amd64"
IUSE="berkdb doc freetds gdbm ldap mysql nss odbc openssl postgres sqlite static-libs"
RESTRICT="test"

RDEPEND="dev-libs/expat
	>=dev-libs/apr-${APR_PV}:1
	berkdb? ( >=sys-libs/db-4 )
	freetds? ( dev-db/freetds )
	gdbm? ( sys-libs/gdbm )
	ldap? ( =net-nds/openldap-2* )
	mysql? ( =virtual/mysql-5* )
	nss? ( dev-libs/nss )
	odbc? ( dev-db/unixODBC )
	openssl? ( dev-libs/openssl )
	postgres? ( dev-db/postgresql-base )
	sqlite? ( dev-db/sqlite:3 )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

DOCS=(CHANGES NOTICE README)

src_prepare() {
	eautoreconf

	elibtoolize
}

src_configure() {
	local myconf

	[[ ${CHOST} == *-mint* ]] && myconf="${myconf} --disable-util-dso"

	if use berkdb; then
		local db_version
		db_version="$(db_findver sys-libs/db)" || die "Unable to find Berkeley DB version"
		db_version="$(db_ver_to_slot "${db_version}")"
		db_version="${db_version/\./}"
		myconf+=" --with-dbm=db${db_version} --with-berkeley-db=$(db_includedir 2> /dev/null):${EPREFIX}/usr/$(get_libdir)"
	else
		myconf+=" --without-berkeley-db"
	fi

	econf \
		--datadir="${EPREFIX}"/usr/share/apr-util-1 \
		--with-apr="${EPREFIX}"/usr \
		--with-expat="${EPREFIX}"/usr \
		--without-sqlite2 \
		$(use_with freetds) \
		$(use_with gdbm) \
		$(use_with ldap) \
		$(use_with mysql) \
		$(use_with nss) \
		$(use_with odbc) \
		$(use_with openssl) \
		$(use_with postgres pgsql) \
		$(use_with sqlite sqlite3) \
		${myconf}
}

src_compile() {
	emake CPPFLAGS="${CPPFLAGS}" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"

	if use doc; then
		emake dox
	fi
}

src_install() {
	default

	find "${ED}" -name "*.la" -exec rm -f {} +
	find "${ED}usr/$(get_libdir)/apr-util-${SLOT}" -name "*.a" -exec rm -f {} +

	if use doc; then
		dohtml -r docs/dox/html/*
	fi

	if ! use static-libs; then
		find "${ED}" -name "*.a" -exec rm -f {} +
	fi

	# This file is only used on AIX systems, which Gentoo is not,
	# and causes collisions between the SLOTs, so remove it.
	rm -f "${ED}usr/$(get_libdir)/aprutil.exp"
}