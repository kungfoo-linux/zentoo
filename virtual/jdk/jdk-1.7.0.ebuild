# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Virtual for Java Development Kit (JDK)"
SLOT="1.7"
KEYWORDS="amd64"

RDEPEND="|| (
		=dev-java/icedtea-bin-7*
		=dev-java/icedtea-7*
		=dev-java/oracle-jdk-bin-1.7.0*
		=dev-java/soylatte-jdk-bin-7*
	)"
