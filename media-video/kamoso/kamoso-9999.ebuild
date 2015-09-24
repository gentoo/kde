# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde5

DESCRIPTION="Application to take pictures and videos from your webcam by KDE"
HOMEPAGE="https://userbase.kde.org/Kamoso"

LICENSE="GPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_kdeapps_dep libkipi)
	dev-libs/purpose:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	media-libs/qt-gstreamer[qt5]
	virtual/udev
"
RDEPEND="${DEPEND}
	media-plugins/gst-plugins-meta[alsa,theora,vorbis,v4l,xv]
"
