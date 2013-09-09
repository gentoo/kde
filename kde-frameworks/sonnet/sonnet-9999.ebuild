# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_DOXYGEN="true"
FRAMEWORKS_TYPE="tier1"
inherit kde-frameworks

DESCRIPTION="Multilingual language processing architecture"
LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE="spell"

RDEPEND="
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	spell? ( app-text/enchant )
"
DEPEND="${RDEPEND}
	test? ( dev-qt/qtxml:5 )
"

DOCS=( README )

src_configure() {
	# The features provided by aspell, hspell, and hunspell
	# are all available via enchant.
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_ASPELL=true
		-DCMAKE_DISABLE_FIND_PACKAGE_HSPELL=true
		-DCMAKE_DISABLE_FIND_PACKAGE_HUNSPELL=true
		$(cmake-utils_use_find_package spell ENCHANT)
	)

	kde-frameworks_src_configure
}
