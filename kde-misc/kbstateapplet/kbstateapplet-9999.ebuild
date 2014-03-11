# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="playground/base/plasma"
KMMODULE="applets/${PN}"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="Plasmoid that shows the state of keyboard leds"
HOMEPAGE="http://websvn.kde.org/trunk/playground/base/plasma/applets/kbstateapplet"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	x11-libs/libX11
"
RDEPEND="
	${DEPEND}
	$(add_kdebase_dep plasma-workspace)
"
