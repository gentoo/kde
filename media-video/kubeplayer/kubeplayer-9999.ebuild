# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Multimedia player for different online platforms"
HOMEPAGE="http://projects.kde.org/projects/playground/multimedia/kubeplayer"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS=""
IUSE="debug gstreamer"

DEPEND="
	dev-ruby/json
	$(add_kdebase_dep korundum)
	$(add_kdebase_dep smokegen)
	$(add_kdebase_dep smokekde)
	$(add_kdebase_dep smokeqt)
	gstreamer? (
		media-plugins/gst-plugins-faad
		media-plugins/gst-plugins-ffmpeg
		media-plugins/gst-plugins-soup
	)
"
RDEPEND="${DEPEND}"
