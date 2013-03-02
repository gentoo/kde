# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

QT_MINIMAL="4.8.0"
inherit cmake-utils git-2

DESCRIPTION="Collection of libraries to integrate Last.fm services"
HOMEPAGE="http://github.com/eartle/liblastfm"
EGIT_REPO_URI="git://github.com/eartle/liblastfm.git"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="0/0"
IUSE="fingerprint test"

COMMON_DEPEND="
	>=dev-qt/qtcore-${QT_MINIMAL}:4
	>=dev-qt/qtdbus-${QT_MINIMAL}:4
	fingerprint? (
		media-libs/libsamplerate
		sci-libs/fftw:3.0
		>=dev-qt/qtsql-${QT_MINIMAL}:4
	)
"
DEPEND="${COMMON_DEPEND}
	test? ( >=dev-qt/qttest-${QT_MINIMAL}:4 )
"
RDEPEND="${COMMON_DEPEND}
	!<media-libs/lastfmlib-0.4.0
"

# 1 of 2 is failing, last checked 2012-06-22 / version 1.0.1
RESTRICT="test"

src_configure() {
	# demos not working
	local mycmakeargs=(
		-DBUILD_DEMOS=OFF
		$(cmake-utils_use_build fingerprint)
		$(cmake-utils_use_build test TESTS)
	)

	cmake-utils_src_configure
}
