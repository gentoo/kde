# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
EGIT_BRANCH="qt5"
inherit kde5 python-any-r1

DESCRIPTION="Qt bindings for the Telepathy logger"
HOMEPAGE="https://projects.kde.org/projects/extragear/network/telepathy/telepathy-logger-qt"

LICENSE="LGPL-2.1"
SLOT="5"
IUSE=""

RDEPEND="
	dev-libs/glib
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	media-libs/qt-gstreamer[qt5]
	net-im/telepathy-logger
	net-libs/telepathy-glib
	net-libs/telepathy-qt[qt5]
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	sys-devel/bison
	sys-devel/flex
"

src_prepare() {
	sed -i -e 's/INCLUDE(Qt5Macros)//g' cmake/modules/FindQt5.cmake || die "couldn't remove Qt5Macros include"
}

src_configure() {
	export QT_SELECT=5
	cmake-utils_src_configure
}
