# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base python

DESCRIPTION="Qt4 bindings for the Telepathy logger"
HOMEPAGE="https://projects.kde.org/projects/extragear/network/telepathy/telepathy-logger-qt"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://kde/unstable/kde-telepathy/${PV}/src/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="debug"

RDEPEND="
	media-libs/qt-gstreamer
	>=net-im/telepathy-logger-0.2.12-r1
	>=net-libs/telepathy-qt-0.9.1
"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
	)
	kde4-base_src_configure
}
