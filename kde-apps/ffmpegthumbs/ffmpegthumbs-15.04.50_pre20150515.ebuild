# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="frameworks"
inherit kde5 git-r3

DESCRIPTION="A FFmpeg based thumbnail Generator for Video Files"
KEYWORDS=" ~amd64 ~x86"
IUSE=""

EGIT_REPO_URI="git://anongit.kde.org/${PN}"
EGIT_COMMIT="c06602ff79ac5e3eb94cef2c680135caa1a3c53c"
SRC_URI=""

RDEPEND="
	$(add_frameworks_dep kio)
	dev-qt/qtgui:5
	virtual/ffmpeg"

DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"
