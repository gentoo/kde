# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde5

DESCRIPTION="An FFmpeg based thumbnail generator for video files"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kio)
	dev-qt/qtgui:5
	virtual/ffmpeg
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"
