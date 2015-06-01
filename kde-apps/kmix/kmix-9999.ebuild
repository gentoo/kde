# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="false"
KDE_TEST="false"
inherit kde5

DESCRIPTION="Plasma mixer gui"
HOMEPAGE="http://www.kde.org/applications/multimedia/kmix/"
KEYWORDS=""
IUSE="alsa canberra pulseaudio"

DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	dev-libs/glib:2
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	alsa? ( >=media-libs/alsa-lib-1.0.14a )
	canberra? ( media-libs/libcanberra )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.12 )
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-15.04.2-alsa-optional.patch" )

src_configure() {
	local mycmakeargs=(
		-DKMIX_KF5_BUILD=ON
		$(cmake-utils_use_find_package alsa)
		$(cmake-utils_use_find_package canberra)
		$(cmake-utils_use_find_package pulseaudio PulseAudio)
	)

	kde5_src_configure
}
