# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake kde.org

DESCRIPTION="Qt library to query the movie database API (themoviedb.org)"
HOMEPAGE="https://invent.kde.org/libraries/libtmdbqt"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="test"

RESTRICT="!test? ( test )"

DEPEND="dev-qt/qtbase:6[network]"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DTMDBQT_ENABLE_TESTS=$(usex test)
	)

	cmake_src_configure
}
