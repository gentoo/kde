# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [ ${PV} == "9999" ]; then
	EGIT_REPO_URI="http://git.code.sf.net/p/bekwinfx/code"
	KEYWORDS=""
fi
KDE_MINIMAL="4.10"

inherit cmake-utils git-2

OPENGL_REQUIRED=always
KDE_HANDBOOK=optional

DESCRIPTION="BE::KWinFW Several 3rd party plugins for the KDE KWin compositor."
HOMEPAGE="http://sourceforge.net/projects/bekwinfx/"

DEPEND="${DEPEND}
	xrandr? ( kde-base/kephal )
	gles? ( kde-base/kwin[gles] )"
LICENSE="GPL-2"
SLOT="0"
IUSE="+beclock +beanimated +befaded bereflected bedistorted debug gles +xrandr"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build beclock CLOCK)
		$(cmake-utils_use_build beanimated ANIMATED)
		$(cmake-utils_use_build befaded FADED)
		$(cmake-utils_use_build bereflected REFLECTED)
		$(cmake-utils_use_build bedistorted DISTORTED)
	)

	cmake-utils_src_configure
}
