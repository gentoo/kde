# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="Integrated Development Environment for Unix, supporting KDE/Qt, C/C++ and many other languages."
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/unstable/${PN}/${PV}/src/${P}.tar.bz2"

IUSE="cmake +cxx debug qmake"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2 LGPL-2"
SLOT="4"

DEPEND=">=kde-base/kapptemplate-${KDE_MINIMAL}
		>=dev-util/kdevplatform-0.9.85"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DBUILD_cmake=$(useq cmake && echo On || echo Off)
		-DBUILD_cmakebuilder=$(useq cmake && echo On || echo Off)
		-DBUILD_qmake=$(useq qmake && echo On || echo Off)
		-DBUILD_qmakebuilder=$(useq qmake && echo On || echo Off)
		-DBUILD_cpp=$(useq cxx && echo On || echo Off)"

	kde4-base_src_configure
}

#src_install() {
#	kde4-base_src_install
#
#	rm "${D}/${KDEDIR}"/share/apps/kdevappwizard/templates/qmake_qt4guiapp.tar.bz2
#	rm "${D}/${KDEDIR}"/share/icons/hicolor/22x22/actions/output_win.png
#}
