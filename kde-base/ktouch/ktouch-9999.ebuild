# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE: A program that helps you to learn and practice touch typing"
HOMEPAGE="http://edu.kde.org/applications/miscellaneous/ktouch"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	$(add_kdeapps_dep knotify)
	$(add_kdeapps_dep kqtquickcharts)
	$(add_kdeapps_dep plasma-runtime)
"
