# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="GNU regular expression matcher"
HOMEPAGE="https://www.gnu.org/software/grep/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz
	mirror://gentoo/${P}.tar.xz
	https://dev.gentoo.org/~polynomial-c/${P}-heap_buffer_overrun.patch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="nls pcre static"

LIB_DEPEND="pcre? ( >=dev-libs/libpcre-7.8-r1[static-libs(+)] )"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )
	nls? ( virtual/libintl )
	virtual/libiconv"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
	static? ( ${LIB_DEPEND} )"

DOCS=( AUTHORS ChangeLog NEWS README THANKS TODO )

src_prepare() {
	# Disable gnulib build test that has no impact on the source.
	# Re-enable w/next version bump (and gnulib is updated). #554728
	[[ ${PV} != "2.21" ]] && die "re-enable test #554728"
	echo 'exit 0' > gnulib-tests/test-update-copyright.sh || die

	sed -i \
		-e "s:@SHELL@:${EPREFIX}/bin/sh:g" \
		src/egrep.sh || die #523898

	epatch "${DISTDIR}/${P}-heap_buffer_overrun.patch"
}

src_configure() {
	use static && append-ldflags -static
	# Always use pkg-config to get lib info for pcre.
	export ac_cv_search_pcre_compile=$(
		usex pcre "$($(tc-getPKG_CONFIG) --libs $(usex static --static '') libpcre)" ''
	)
	econf \
		--bindir="${EPREFIX}"/bin \
		$(use_enable nls) \
		$(use_enable pcre perl-regexp)
}
