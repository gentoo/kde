# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KDE_MINIMAL="4.4"

inherit kde4-base git

DESCRIPTION="simple backup system for KDE"
HOMEPAGE="http://gitorious.org/timevault"
EGIT_REPO_URI="git://gitorious.org/timevault/mainline.git"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS=""
IUSE=""

DEPEND="app-backup/rdiff-backup"
RDEPEND="${DEPEND}"

src_install() {
	kde4-base_src_install
	rm "${D}/usr/share/apps/cmake/modules/PkgConfigGetVar.cmake" || die "workaround deletion failed"
}
