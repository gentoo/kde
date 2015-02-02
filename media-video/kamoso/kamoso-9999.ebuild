# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="A KDE application to take pictures and videos from your webcam"
HOMEPAGE="http://projects.kde.org/projects/extragear/multimedia/kamoso"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="4"
IUSE="debug nepomuk"

DEPEND="
	$(add_kdebase_dep kdelibs 'nepomuk?')
	$(add_kdebase_dep libkipi)
	media-libs/phonon[qt4]
	media-libs/qt-gstreamer
"
RDEPEND="${DEPEND}
	media-plugins/gst-plugins-meta[alsa,theora,vorbis,v4l,xv]
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with nepomuk)
	)

	kde4-base_src_configure
}
