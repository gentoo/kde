# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDEBASE="kdevelop"
KMNAME="kdev-qmake"
inherit kde4-base

DESCRIPTION="qmake plugin for KDevelop 4"
LICENSE="LGPL-2"
KEYWORDS=""
IUSE="debug tools"

DEPEND="
	dev-util/kdevelop:4
	dev-util/kdevelop-pg-qt
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build tools qmake_parser)
	)

	kde4-base_src_configure
}

src_install() {
	kde4-base_src_install
	#Move this file to prevent a collision with kappwizard
	mv "${D}"/usr/share/apps/kdevappwizard/templates/qmake_qt4guiapp.tar.bz2 "${D}"/usr/share/apps/kdevappwizard/templates/kdevelop-qmake_qt4guiapp.tar.bz2
}
