# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
fi

DESCRIPTION="Script used to reinstall Python packages after changing active Python versions"
HOMEPAGE="https://www.gentoo.org/proj/en/Python/"
if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="git://anongit.gentoo.org/proj/python-updater.git"
else
	SRC_URI="https://dev.gentoo.org/~floppym/dist/${P}.tar.bz2"
	KEYWORDS="amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

if [[ ${PV} == 9999 ]]; then
	DEPEND="
		sys-apps/gentoo-functions
		sys-apps/help2man
	"
fi
RDEPEND="
	sys-apps/gentoo-functions
	|| ( >=sys-apps/portage-2.1.6 >=sys-apps/paludis-0.56.0 sys-apps/pkgcore )
"

src_compile() {
	[[ ${PV} == 9999 ]] && emake python-updater
	default
}
