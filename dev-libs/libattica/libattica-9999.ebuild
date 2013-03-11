# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_P="${P#lib}"
MY_PN="${PN#lib}"

inherit cmake-utils git-2

DESCRIPTION="A library providing access to Open Collaboration Services"
HOMEPAGE="http://www.kde.org/"
EGIT_REPO_URI="git://anongit.kde.org/attica"

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug +qt4 qt5 test"

REQUIRED_USE="^^ ( qt4 qt5 )"

RDEPEND="
	qt4? ( dev-qt/qtcore:4 )
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtnetwork:5
	)
"
DEPEND="${RDEPEND}
	qt5? ( dev-libs/extra-cmake-modules )
	test? (
		qt4? (
			dev-qt/qtgui:4
			dev-qt/qttest:4
		)
		qt5? (
			dev-qt/qttest:5
			dev-qt/qtwidgets:5
		)
	)
"

DOCS=( AUTHORS ChangeLog README )

S=${WORKDIR}/${MY_P}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package qt5 Qt5Core)
		$(cmake-utils_use test ATTICA_ENABLE_TESTS)
	)
	cmake-utils_src_configure
}
