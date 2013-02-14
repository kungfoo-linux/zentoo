# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

ANT_TASK_DEPNAME=""
ANT_TASK_DISABLE_VM_DEPS="true"

inherit ant-tasks

DESCRIPTION="Apache Ant .jar with optional tasks depending on XML transformer (Deprecated!)"
KEYWORDS="amd64"
IUSE=""

DEPEND=">=virtual/jdk-1.4" #jar

src_compile() {
	# the classes were moved to ant-core in 1.8.1, this is just for compatibility
	mkdir -p build/lib/empty && cd build/lib/empty || die
	jar -cf ../${PN}.jar .
}

pkg_postinst() {
	elog "Upstream has removed ant-trax.jar as of 1.8.1 and moved the classes to ant.jar"
	elog "This package thus installs an empty jar for compatibility"
	elog "and will be removed once reverse dependencies are transitioned."
}
