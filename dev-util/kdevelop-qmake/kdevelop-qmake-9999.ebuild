# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kdev-qmake"
inherit kde4-base

DESCRIPTION="Adds suppport for qmake projects to kdevelop."
HOMEPAGE="http://www.kdevelop.org"

LICENSE="LGPL-2"
SLOT="4"
KEYWORDS=""
IUSE="tools"

RESTRICT="test" #Tests fail, and we usually don't want to run tests on live
				#versions anyway
DEPEND="
	dev-util/kdevelop
	>=dev-util/kdevplatform-1.3.60
	dev-util/kdevelop-pg-qt
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build tools qmake_parser)
	)
	kde4-base_src_configure
}

src_install() {
	kde4-base_src_install
	#Move this file to prevent a collision with kappwizard
	mv "${D}"/usr/share/apps/kdevappwizard/templates/qmake_qt4guiapp.tar.bz2 "${D}"/usr/share/apps/kdevappwizard/templates/kdevelop-qmake_qt4guiapp.tar.bz2
}
