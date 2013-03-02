# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils flag-o-matic git-2

DESCRIPTION="KDE Meta Object Compiler"
HOMEPAGE="http://www.kde.org"
EGIT_REPO_URI="git://anongit.kde.org/automoc"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtcore:4
"
RDEPEND="${DEPEND}"

src_prepare() {
	if [[ ${ELIBC} = uclibc ]]; then
		append-flags -pthread
	fi
}
