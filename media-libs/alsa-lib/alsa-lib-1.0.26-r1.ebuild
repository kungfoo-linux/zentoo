# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit autotools eutils multilib python-single-r1

DESCRIPTION="Advanced Linux Sound Architecture Library"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/lib/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc debug alisp python"

RDEPEND="python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}
	>=media-sound/alsa-headers-1.0.25
	doc? ( >=app-doc/doxygen-1.2.6 )"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/1.0.25-extraneous-cflags.diff
	eautoreconf
	# if eautoreconf'd with recent autoconf, then epunt_cxx is
	# unncessary wrt #460974
#	epunt_cxx
}

src_configure() {
	local myconf
	use elibc_uclibc && myconf="--without-versioned"

	econf \
		--enable-shared \
		--disable-resmgr \
		--enable-rawmidi \
		--enable-seq \
		--enable-aload \
		$(use_with debug) \
		$(use_enable alisp) \
		$(use_enable python) \
		${myconf}
}

src_compile() {
	emake

	if use doc; then
		emake doc
		fgrep -Zrl "${S}" "${S}/doc/doxygen/html" | \
			xargs -0 sed -i -e "s:${S}::"
	fi
}

src_install() {
	emake DESTDIR="${D}" install

	prune_libtool_files --all
	find "${ED}"/usr/$(get_libdir)/alsa-lib -name '*.a' -exec rm -f {} +

	dodoc ChangeLog TODO
	use doc && dohtml -r doc/doxygen/html/*
}
