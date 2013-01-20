# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit multilib toolchain-funcs eutils flag-o-matic

if [[ ${PV} == *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="http://git.chromium.org/webm/${PN}.git"
	KEYWORDS=""
elif [[ ${PV} == *pre* ]]; then
	SRC_URI="mirror://gentoo/${P}.tar.bz2"
	KEYWORDS="amd64"
else
	SRC_URI="http://webm.googlecode.com/files/${PN}-v${PV}.tar.bz2"
	KEYWORDS="amd64"
	S="${WORKDIR}/${PN}-v${PV}"
fi

DESCRIPTION="WebM VP8 Codec SDK"
HOMEPAGE="http://www.webmproject.org"

LICENSE="BSD"
SLOT="0"
IUSE="altivec debug doc mmx postproc sse sse2 sse3 ssse3 sse4_1 static-libs +threads"

RDEPEND=""
DEPEND="amd64? ( dev-lang/yasm )
	x86? ( dev-lang/yasm )
	x86-fbsd? ( dev-lang/yasm )
	doc? (
		app-doc/doxygen
		dev-lang/php
	)
"

REQUIRED_USE="
	sse2? ( mmx )
	"
src_prepare() {
	epatch "${FILESDIR}"/${P}-support-arm.patch
}

src_configure() {
	replace-flags -ggdb3 -g #402825

	unset CODECS #357487

	#let the build system decide which AS to use (it honours $AS but
	#then feeds it with yasm flags without checking...) bug 345161
	unset AS

	# http://bugs.gentoo.org/show_bug.cgi?id=384585
	addpredict /usr/share/snmp/mibs/.index

	# http://bugs.gentoo.org/379659 http://gerrit.chromium.org/gerrit/#change,18142
	export LC_ALL=C

	tc-export CC
	./configure \
		--prefix="${EPREFIX}"/usr \
		--libdir="${EPREFIX}"/usr/$(get_libdir) \
		--enable-pic \
		--enable-vp8 \
		--enable-shared \
		$(use_enable altivec) \
		$(use_enable debug debug-libs) \
		$(use_enable debug) \
		$(use_enable doc install-docs) \
		$(use_enable mmx) \
		$(use_enable postproc) \
		$(use_enable sse) \
		$(use_enable sse2) \
		$(use_enable sse3) \
		$(use_enable sse4_1) \
		$(use_enable ssse3) \
		$(use_enable static-libs static ) \
		$(use_enable threads multithread) \
		|| die
}

src_install() {
	# Override base.eclass's src_install.
	default
}
