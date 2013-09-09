# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_DOXYGEN="true"
FRAMEWORKS_TYPE="tier1"
inherit kde-frameworks

DESCRIPTION="Helper library for multithreaded programming"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
DEPEND="${RDEPEND}"

DOCS=( Announce-0.5.txt ChangeLog ChangeLog-Pre-KDESVN Ideas-RFC.txt TODO )
