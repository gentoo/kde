# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KMNAME="polkit-qt-1"
inherit kde5

DESCRIPTION="PolicyKit Qt5 API wrapper library"
HOMEPAGE="https://api.kde.org/kdesupport-api/polkit-qt-1-apidocs/"

LICENSE="LGPL-2"
KEYWORDS=""
IUSE="examples"

DEPEND="
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	dev-libs/glib:2
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
