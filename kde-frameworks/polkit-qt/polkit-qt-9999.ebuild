# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KMNAME="polkit-qt-1"
inherit kde5

DESCRIPTION="PolicyKit Qt5 API wrapper library"
HOMEPAGE="http://www.kde.org/"

LICENSE="LGPL-2"
KEYWORDS=""
IUSE="examples"

DEPEND="
	dev-libs/glib:2
	$(add_qt_dep qtcore)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	>=sys-auth/polkit-0.103
	examples? ( $(add_qt_dep qtxml) )
"
RDEPEND="${DEPEND}
	!sys-auth/polkit-qt[qt5]
"

DOCS=( AUTHORS README README.porting TODO )

src_configure() {
	local mycmakeargs=(
		-DSYSCONF_INSTALL_DIR="${EPREFIX}"/etc
		-DBUILD_EXAMPLES=$(usex examples)
		-DUSE_QT5=on
	)

	kde5_src_configure
}
