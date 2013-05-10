# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit gnome.org multilib libtool

DESCRIPTION="Image loading library for GTK+"
HOMEPAGE="http://www.gtk.org/"

LICENSE="LGPL-2+"
SLOT="2"
KEYWORDS="amd64"
IUSE="+X debug +introspection jpeg jpeg2k tiff test"

COMMON_DEPEND="
	>=dev-libs/glib-2.31.0:2
	>=media-libs/libpng-1.4:0
	introspection? ( >=dev-libs/gobject-introspection-0.9.3 )
	jpeg? ( virtual/jpeg )
	jpeg2k? ( media-libs/jasper )
	tiff? ( >=media-libs/tiff-3.9.2:0 )
	X? ( x11-libs/libX11 )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/gtk-doc-am-1.11
	>=sys-devel/gettext-0.17
	virtual/pkgconfig"
# librsvg blocker is for the new pixbuf loader API, you lose icons otherwise
RDEPEND="${COMMON_DEPEND}
	!<gnome-base/gail-1000
	!<gnome-base/librsvg-2.31.0
	!<x11-libs/gtk+-2.21.3:2
	!<x11-libs/gtk+-2.90.4:3"

src_prepare() {
	# This will avoid polluting the pkg-config file with versioned libpng,
	# which is causing problems with libpng14 -> libpng15 upgrade
	# See upstream bug #667068
	sed -e 's:libpng15:libpng libpng15:' \
		-i configure || die
	default
	elibtoolize # for Darwin modules
}

src_configure() {
	# png always on to display icons (foser)
	local myconf="
		$(use_with jpeg libjpeg)
		$(use_with jpeg2k libjasper)
		$(use_with tiff libtiff)
		$(use_enable introspection)
		$(use_with X x11)
		--with-libpng"

	# Passing --disable-debug is not recommended for production use
	use debug && myconf="${myconf} --enable-debug=yes"

	econf ${myconf}
}

src_install() {
	default
	dodoc AUTHORS NEWS* README*

	# New library, remove .la files
	find "${D}" -name '*.la' -exec rm -f '{}' + || die
}

pkg_postinst() {
	# causes segfault if set, see bug 375615
	unset __GL_NO_DSO_FINALIZER

	tmp_file=$(mktemp -t tmp_gdk_pixbuf_ebuild.XXXXXXXXXX)
	# be atomic!
	gdk-pixbuf-query-loaders > "${tmp_file}"
	if [ "${?}" = "0" ]; then
		cat "${tmp_file}" > "${EROOT}usr/$(get_libdir)/gdk-pixbuf-2.0/2.10.0/loaders.cache"
	else
		ewarn "Cannot update loaders.cache, gdk-pixbuf-query-loaders failed to run"
	fi
	rm "${tmp_file}"

	if [ -e "${EROOT}"usr/lib/gtk-2.0/2.*/loaders ]; then
		elog "You need to rebuild ebuilds that installed into" "${EROOT}"usr/lib/gtk-2.0/2.*/loaders
		elog "to do that you can use qfile from portage-utils:"
		elog "emerge -va1 \$(qfile -qC ${EPREFIX}/usr/lib/gtk-2.0/2.*/loaders)"
	fi
}
