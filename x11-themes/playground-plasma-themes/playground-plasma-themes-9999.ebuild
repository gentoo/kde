# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="playground/base/plasma/desktoptheme"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="Plasma themes from KDE playground."
HOMEPAGE="http://plasma.kde.org/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE=""

RDEPEND="
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
"
