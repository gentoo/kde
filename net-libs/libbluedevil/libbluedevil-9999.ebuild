# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="Qt wrapper for bluez used in the KDE bluetooth stack"
HOMEPAGE="http://projects.kde.org/projects/playground/libs/libbluedevil"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtdbus:5
"
RDEPEND="${DEPEND}
	>=net-wireless/bluez-5
	!net-libs/libbluedevil:4
"
