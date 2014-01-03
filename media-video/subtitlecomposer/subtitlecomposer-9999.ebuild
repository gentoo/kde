# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS="bg cs de el es fr it pl pt_BR sr"
KDE_SCM="svn"
inherit kde4-base

DESCRIPTION="Text-based subtitles editor."
HOMEPAGE="http://www.sourceforge.net/projects/subcomposer/"
ESVN_REPO_URI="https://subcomposer.svn.sourceforge.net/svnroot/subcomposer/trunk"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug gstreamer unicode xine"

RDEPEND="
	media-libs/phonon
	gstreamer? ( media-libs/gstreamer:0.10 )
	unicode? ( dev-libs/icu:= )
	xine? ( media-libs/xine-lib )
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

src_prepare() {
	kde4-base_src_prepare

	sed -e '/ADD_SUBDIRECTORY( api )/s/^/# DISABLED/' \
		-i src/main/scripting/examples/CMakeLists.txt \
		|| die "failed to disable installation of scripting API"
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with gstreamer GStreamer)
		$(cmake-utils_use_with unicode ICU)
		$(cmake-utils_use_with xine)
	)
	kde4-base_src_configure
}

pkg_postinst() {
	kde4-base_pkg_postinst

	echo
	elog "Some example scripts provided by ${PV} require dev-lang/ruby"
	elog "or dev-lang/python to be installed."
	echo
}
