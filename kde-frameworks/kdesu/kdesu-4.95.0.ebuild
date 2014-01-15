# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_TEST="false"
inherit kde-frameworks

DESCRIPTION="Framework to handle super user actions"
LICENSE="LGPL-2"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kpty)
	$(add_frameworks_dep kservice)
"
DEPEND="${RDEPEND}
	dev-qt/qtwidgets:5
	x11-proto/xproto
"
