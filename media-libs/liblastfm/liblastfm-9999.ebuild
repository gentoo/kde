# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Collection of libraries to integrate Last.fm services"
HOMEPAGE="https://github.com/lastfm/liblastfm"
EGIT_REPO_URI=( "https://github.com/lastfm/${PN}" )

LICENSE="GPL-3"
SLOT="0/0"
KEYWORDS=""
IUSE="fingerprint test"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtnetwork:5[ssl]
	dev-qt/qtxml:5
	fingerprint? (
		dev-qt/qtsql:5
		media-libs/libsamplerate
		sci-libs/fftw:3.0
	)
"
DEPEND="${RDEPEND}
	test? ( dev-qt/qttest:5 )
"

# 1 of 2 (UrlBuilderTest) is failing, last checked version 1.0.9
RESTRICT="test"

src_configure() {
	# demos not working
	local mycmakeargs=(
		-DBUILD_DEMOS=OFF
		-DBUILD_WITH_QT4=OFF
		-DBUILD_FINGERPRINT=$(usex fingerprint)
		-DBUILD_TESTS=$(usex test)
	)

	cmake_src_configure
}
