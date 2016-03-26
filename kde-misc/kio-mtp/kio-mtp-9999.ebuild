# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="MTP KIO-Client for Plasma"
HOMEPAGE="https://projects.kde.org/projects/playground/base/kio-mtp"

LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep solid)
	>=media-libs/libmtp-1.1.3
"
RDEPEND="${DEPEND}
	!kde-misc/kio-mtp:4
"
