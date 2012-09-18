# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="The Byte Code Engineering Library: analyze, create, manipulate Java class files"
HOMEPAGE="http://commons.apache.org/bcel/"
SRC_URI="mirror://apache/jakarta/${PN}/source/${P}-src.tar.gz
	findbugs? ( http://dev.gentoo.org/~fordfrog/distfiles/findbugs-${P}_p20070531.patch.bz2 )"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="-findbugs"

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

ANT_OPTS="-Xmx256m"

java_prepare() {
	epatch "${FILESDIR}/${P}"-build.xml.patch
	if use findbugs; then
		# Remove next line if no longer needed. Removes build.xml from patch.
		patch -d "${WORKDIR}" -p0 < "${FILESDIR}"/findbugs-${P}_p20070531.patch.patch || die "Failed to patch"

		EPATCH_OPTS="-p7" epatch "${WORKDIR}"/findbugs-${P}_p20070531.patch
	fi
}

src_install() {
	java-pkg_newjar ./target/${P}.jar
	dodoc README.txt || die

	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/*
}