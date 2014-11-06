# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-frameworks/knotifyconfig/knotifyconfig-5.3.0.ebuild,v 1.1 2014/10/15 13:29:46 kensington Exp $

EAPI=5

KDE_TEST="false"
inherit kde5

DESCRIPTION="Framework for configuring desktop notifications"
LICENSE="LGPL-2+"
KEYWORDS=" ~amd64"
IUSE="phonon"

RDEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kservice)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	phonon? ( media-libs/phonon[qt5] )
"
DEPEND="${RDEPEND}"
