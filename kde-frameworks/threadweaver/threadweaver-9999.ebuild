# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_DOXYGEN="true"
inherit kde-frameworks

DESCRIPTION="High-level API to manage threads using job and queue-based interfaces"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
DEPEND="${RDEPEND}"

DOCS=( Announce-0.5.txt ChangeLog ChangeLog-Pre-KDESVN Ideas-RFC.txt TODO )
