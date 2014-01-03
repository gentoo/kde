# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="A KDE application to take pictures and videos from your webcam"
HOMEPAGE="http://projects.kde.org/projects/extragear/multimedia/kamoso"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	>=media-libs/qt-gstreamer-0.10
	$(add_kdebase_dep libkipi)
"
RDEPEND="${DEPEND}
	media-plugins/gst-plugins-meta[alsa,theora,vorbis,v4l,xv]
"
