# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit java-virtuals-2

DESCRIPTION="Virtual for javamail implementations"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="|| ( dev-java/sun-javamail >=dev-java/gnu-javamail-1.0-r2 )
		!<dev-java/gnu-javamail-1.0-r2"

JAVA_VIRTUAL_PROVIDES="sun-javamail gnu-javamail-1"