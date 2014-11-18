# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="A FFmpeg based thumbnail Generator for Video Files"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kio)
	dev-qt/qtgui:5
	virtual/ffmpeg"

DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"
