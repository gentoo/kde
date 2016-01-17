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
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	>=sys-auth/polkit-0.103
	examples? ( dev-qt/qtxml:5 )
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
