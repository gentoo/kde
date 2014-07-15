# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
if [[ $PV = *9999* ]]; then
	EGIT_BRANCH="frameworks"
	KEYWORDS=""
else
	SRC_URI="mirror://kde/stable/plasma/5.0.0/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

inherit kde5

DESCRIPTION="KDE screen management library"
HOMEPAGE="https://projects.kde.org/projects/extragear/libs/libkscreen"

LICENSE="GPL-2"
IUSE=""

# TODO: add X use flag, does not build at the moment

DEPEND="
	dev-qt/qtgui:5
	dev-qt/qtx11extras:5
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXrandr
"
RDEPEND="${DEPEND}"
