# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="Framework providing additional format plugins for Qt's image I/O system"
LICENSE="LGPL-2+"
KEYWORDS=" ~amd64"
IUSE="eps jpeg2k openexr"

RDEPEND="
	dev-qt/qtgui:5
	eps? ( dev-qt/qtprintsupport:5 )
	jpeg2k? ( media-libs/jasper )
	openexr? (
		media-libs/ilmbase:=
		media-libs/openexr:=
	)
"
DEPEND="${RDEPEND}"

DOCS=( src/imageformats/AUTHORS )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package eps Qt5PrintSupport)
		$(cmake-utils_use_find_package jpeg2k Jasper)
		$(cmake-utils_use_find_package openexr OpenEXR)
	)

	kde5_src_configure
}
