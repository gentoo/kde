# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [ ${PV} == 9999 ]; then
	EGIT_REPO_URI="http://git.code.sf.net/p/bekwinfx/code"
	KEYWORDS=""
else
	GIT_REV="382e9caa9454f06452b01df5ff54799651a850f1"
	SRC_URI="http://sourceforge.net/code-snapshots/git/b/be/${PN}/code.git/${PN}-code-${GIT_REV}.zip
			-> ${P}.zip"
	S="${WORKDIR}/${PN}-code-${GIT_REV}"
	KEYWORDS="~amd64 ~x86"
fi

KDE_MINIMAL="4.10"
OPENGL_REQUIRED=always

inherit kde4-base

DESCRIPTION="BE::KWinFW Several 3rd party plugins for the KDE KWin compositor"
HOMEPAGE="http://sourceforge.net/projects/bekwinfx/"

DEPEND="
	$(add_kdebase_dep kwin)
	xrandr? ( kde-base/kephal )
	gles? ( kde-base/kwin[gles] )"
RDEPEND="
	${DEPEND}"
LICENSE="GPL-2"
SLOT="4"
IUSE="+beclock beanimated befaded bereflected bedistorted debug gles +xrandr"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build beclock CLOCK)
		$(cmake-utils_use_build beanimated ANIMATED)
		$(cmake-utils_use_build befaded FADED)
		$(cmake-utils_use_build bereflected REFLECTED)
		$(cmake-utils_use_build bedistorted DISTORTED)
	)
	kde4-base_src_configure
}

pkg_postinst() {
	elog "You need active desktop effects to use BEKWinFX effects."
}
