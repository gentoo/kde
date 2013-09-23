# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_TYPE="tier1"
VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Assorted high-level user interface components"
LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE="eps jpeg2k openexr"

RDEPEND="
	dev-qt/qtgui:5
	eps? ( dev-qt/qtprintsupport:5 )
	jpeg2k? ( media-libs/jasper )
	openexr? ( media-libs/openexr:= )
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package eps Qt5PrintSupport)
		$(cmake-utils_use_find_package jpeg2k Jasper)
		$(cmake-utils_use_find_package openexr OpenEXR)
	)

	kde-frameworks_src_configure
}
