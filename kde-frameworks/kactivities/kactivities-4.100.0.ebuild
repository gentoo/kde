# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="Framework for working with KDE activities"
LICENSE="LGPL-2+"
KEYWORDS=" ~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwindowsystem)
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtsql:5
	dev-qt/qtwidgets:5
	!kde-base/kactivities:4[-minimal(-)]
"
DEPEND="${RDEPEND}
	|| ( >=dev-libs/boost-1.54 <dev-libs/boost-1.53 )
"
