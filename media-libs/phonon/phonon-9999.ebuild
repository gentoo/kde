# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/phonon/phonon-9999.ebuild,v 1.19 2013/05/10 17:39:09 kensington Exp $

EAPI=5

if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://kde/stable/phonon/${PV}/src/${P}.tar.xz"
	KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-fbsd ~amd64-linux ~x86-linux ~ppc-macos"
else
	SCM_ECLASS="git-2"
	EGIT_REPO_URI="git://anongit.kde.org/${PN}"
	KEYWORDS=""
fi

inherit cmake-utils multibuild ${SCM_ECLASS}

DESCRIPTION="KDE multimedia API"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/phonon"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="aqua debug +gstreamer pulseaudio +qt4 qt5 vlc zeitgeist"

COMMON_DEPEND="
	!!dev-qt/qtphonon:4
	qt4? (
		>=dev-qt/qtcore-4.6.0:4
		>=dev-qt/qtdbus-4.6.0:4
		>=dev-qt/qtgui-4.6.0:4
		>=dev-qt/qttest-4.6.0:4
	)
	qt5? (
		>=dev-qt/qtcore-5.0.0:5
		>=dev-qt/qtdbus-5.0.0:5
		>=dev-qt/qtdeclarative-5.0.0:5
		>=dev-qt/qtgui-5.0.0:5
		>=dev-qt/qtopengl-5.0.0:5
		>=dev-qt/qttest-5.0.0:5
	)
	pulseaudio? (
		dev-libs/glib:2
		>=media-sound/pulseaudio-0.9.21[glib]
	)
	zeitgeist? ( dev-libs/libqzeitgeist )
"
# directshow? ( media-sound/phonon-directshow )
# mmf? ( media-sound/phonon-mmf )
# mplayer? ( media-sound/phonon-mplayer )
# waveout? ( media-sound/phonon-waveout )
PDEPEND="
	aqua? ( media-libs/phonon-qt7 )
	gstreamer? (
		|| ( <media-libs/phonon-gstreamer-9999 =media-libs/phonon-gstreamer-9999[qt4=,qt5=] )
		qt5? ( =media-libs/phonon-gstreamer-9999[qt5] )
	)
	vlc? (
		|| ( ( >=media-libs/phonon-vlc-0.3.2 <media-libs/phonon-vlc-9999 ) =media-libs/phonon-vlc-9999[qt4=,qt5=] )
		qt5? ( =media-libs/phonon-vlc-9999[qt5] )
	)
"
RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}
	qt4? ( >=dev-util/automoc-0.9.87 )
	virtual/pkgconfig
"

REQUIRED_USE="
	|| ( aqua gstreamer vlc )
	|| ( qt4 qt5 )
	zeitgeist? ( qt4 )
"

pkg_setup() {
	MULTIBUILD_VARIANTS=()
	if use qt4; then
		MULTIBUILD_VARIANTS+=(qt4)
	fi
	if use qt5; then
		MULTIBUILD_VARIANTS+=(qt5)
	fi
}

src_configure() {
	myconfigure() {
		local mycmakeargs=(
			$(cmake-utils_use_with pulseaudio GLIB2)
			$(cmake-utils_use_with pulseaudio PulseAudio)
		)
		if [[ ${MULTIBUILD_VARIANT} = qt4 ]]; then
			mycmakeargs+=(-DPHONON_BUILD_PHONON4QT5=OFF)
		fi
		if [[ ${MULTIBUILD_VARIANT} = qt5 ]]; then
			mycmakeargs+=(-DPHONON_BUILD_PHONON4QT5=ON)
		fi
		cmake-utils_src_configure
	}

	multibuild_foreach_variant myconfigure
}

src_compile() {
	multibuild_foreach_variant cmake-utils_src_compile
}

src_install() {
	multibuild_foreach_variant cmake-utils_src_install
}

src_test() {
	multibuild_foreach_variant cmake-utils_src_test
}
