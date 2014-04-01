# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde-frameworks

DESCRIPTION="Framework for providing spell-checking capabilities through abstraction of popular backends"
LICENSE="LGPL-2+ LGPL-2.1+"
KEYWORDS=" ~amd64"
IUSE="aspell hunspell"

RDEPEND="
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	aspell? ( app-text/aspell )
	hunspell? ( app-text/hunspell )
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package aspell)
		$(cmake-utils_use_find_package hunspell)
	)

	kde-frameworks_src_configure
}
