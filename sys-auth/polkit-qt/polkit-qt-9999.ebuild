# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="PolicyKit Qt API wrapper library"
HOMEPAGE="https://api.kde.org/kdesupport-api/polkit-qt-1-apidocs/"
EGIT_REPO_URI=( "https://anongit.kde.org/polkit-qt-1" )

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug examples"

RDEPEND="
	dev-libs/glib:2
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	>=sys-auth/polkit-0.103
	examples? ( dev-qt/qtxml:5 )
"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS README README.porting TODO )

src_configure() {
	local mycmakeargs=(
		-DBUILD_EXAMPLES=$(usex examples)
		-DUSE_QT4=OFF
		-DUSE_QT5=ON
	)

	cmake-utils_src_configure
}
