# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

DESCRIPTION="Intelligent KDE screen management"
HOMEPAGE="https://projects.kde.org/projects/playground/base/kscreen"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=x11-libs/libkscreen-${PV}
	>=dev-libs/qjson-0.8
"
RDEPEND="${DEPEND}"

pkg_postinst() {
	einfo "To make use of kscreen, run the following"
	einfo "# qdbus org.kde.kded /kded org.kde.kded.unloadModule randrmonitor"
	einfo "# qdbus org.kde.kded /kded org.kde.kded.setModuleAutoloading randrmonitor false"
	einfo "# qdbus org.kde.kded /kded org.kde.kded.loadModule kscreen"
	einfo "Now simply (un-)plugging displays should enable/disable them, while"
	einfo "the last state is remembered."

	kde4-base_pkg_postinst
}
