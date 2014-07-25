# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_TEST="true"
inherit kde5

DESCRIPTION="Qt library to query the novie database API (themoviedb.org)"
HOMEPAGE="https://projects.kde.org/projects/playground/network/libtmdbqt"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtnetwork:5
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use test TMDBQT_ENABLE_TESTS)
	)

	kde5_src_configure
}
