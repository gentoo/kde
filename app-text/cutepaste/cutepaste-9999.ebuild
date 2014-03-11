# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_REQUIRED="never"
inherit kde4-base

DESCRIPTION="Client application for paste.kde.org"
HOMEPAGE="https://projects.kde.org/projects/playground/network/cutepaste"
SRC_URI=""
KEYWORDS=""

LICENSE="GPL-2"
SLOT="4"
IUSE="debug"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtnetwork:5
"
RDEPEND="${DEPEND}"
