# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [ ${PV} == "9999" ]; then
	EGIT_REPO_URI="http://git.code.sf.net/p/bekwinfx/code"
	KEYWORDS=""
	GIT_ECLASS="git-2"
else
	GIT_REVISION="11f4c0f639bee99039ff4d3bd1d947313104b1a7"
	SRC_URI="http://sourceforge.net/code-snapshots/git/b/be/${PN}/code.git/${PN}-code-${GIT_REVISION}.zip
			-> ${P}.zip"
	KEYWORDS="~amd64 ~x86"
fi
KDE_MINIMAL="4.10"

inherit cmake-utils ${GIT_ECLASS}

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

S="${WORKDIR}/${PN}-code-${GIT_REVISION}"

PATCHES=("${FILESDIR}/fix-array.diff")

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

pkg_postinst() {
	elog "You need active desktop effects to use this effects."
}
