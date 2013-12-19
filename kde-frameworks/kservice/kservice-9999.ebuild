# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde-frameworks

DESCRIPTION="Application framework for file type association and plugin locating"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	dev-qt/qtdbus:5
	dev-qt/qtxml:5
"
DEPEND="${RDEPEND}
	test? ( dev-qt/qtconcurrent:5 )
	$(add_frameworks_dep kdoctools)
"
