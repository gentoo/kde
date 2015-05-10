# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="Qt front end for the Oyranos Color Management System"
HOMEPAGE="https://github.com/oyranos-cms/Synnefo"
if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/oyranos-cms/Synnefo.git"
	inherit git-r3
	KEYWORDS=""
#else
#	SRC_URI="https://github.com/oyranos-cms/Synnefo/archive/${PV}.tar.gz -> ${P}.tar.gz"
#	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD-2"
SLOT="0"
IUSE="qt5"

DEPEND="
	=media-libs/oyranos-9999
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
	)
	!qt5? (
		dev-qt/qtcore:4
		dev-qt/qtgui:4
	)
"
RDEPEND="${DEPEND}
	x11-misc/xcalib
"

DOCS=( "AUTHORS.md" "README.md" )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_use !qt5 qt4)
	)
	cmake-utils_src_configure
}
