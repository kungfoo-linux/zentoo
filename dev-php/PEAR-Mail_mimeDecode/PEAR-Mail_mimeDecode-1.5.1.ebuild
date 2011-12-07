# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit php-pear-r1 eutils

DESCRIPTION="Provides a class to decode mime messages (split from PEAR-Mail_Mime)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

# >=PEAR-Mail_Mime-1.5.2 in in DEPEND to avoid blockers and circular deps
# with this package; using PDEPEND in PEAR-Mail_Mime for the same reason

DEPEND=">=dev-php/PEAR-Mail_Mime-1.5.2"