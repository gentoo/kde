# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Network transparent access to files and data"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="acl ssl"

# NOTE From kio/CMakeLists.txt
# Due to a CMake bug, we need to explicitly find private dependencies of our dependencies
# Remove when we depend on CMake 3.0.0
# ---
# So, when cmake 3.0 gets available, this list should be reeviewed!
RDEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kbookmarks)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep solid)
	dev-qt/qtdbus:5
	dev-qt/qtconcurrent:5
	dev-qt/qtnetwork:5
	dev-qt/qtscript:5
	dev-qt/qtxml:5
	dev-qt/qtwidgets:5
	sys-libs/zlib
	acl? ( virtual/acl )
	ssl? ( dev-libs/openssl )
"
DEPEND="${RDEPEND}"

DOCS=( README.md )
