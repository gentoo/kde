# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kde-workspace"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="The KDE Info Center"
HOMEPAGE="http://www.kde.org/applications/system/kinfocenter/"
KEYWORDS=""
IUSE="debug ieee1394"

DEPEND="
	sys-apps/pciutils
	x11-libs/libX11
	ieee1394? ( sys-libs/libraw1394 )
	opengl? (
		virtual/glu
		virtual/opengl
	)
"
RDEPEND="${DEPEND}
	sys-apps/usbutils
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with ieee1394 RAW1394)
		$(cmake-utils_use_with opengl OpenGL)
	)

	kde4-meta_src_configure
}