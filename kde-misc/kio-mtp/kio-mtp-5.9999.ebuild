# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="MTP KIO-Client for KDE"
HOMEPAGE="https://projects.kde.org/projects/playground/base/kio-mtp"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=media-libs/libmtp-1.1.3
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep solid)
	$(add_frameworks_dep kio)
"
RDEPEND="${DEPEND}"
