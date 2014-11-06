# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-frameworks/kmediaplayer/kmediaplayer-5.3.0.ebuild,v 1.1 2014/10/15 13:29:47 kensington Exp $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Framework providing a common interface for KParts that can play media files"
LICENSE="MIT"
KEYWORDS=" ~amd64"
IUSE=""

RDEPEND="
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kxmlgui)
	dev-qt/qtdbus:5
	dev-qt/qtwidgets:5
"
DEPEND="${RDEPEND}"
