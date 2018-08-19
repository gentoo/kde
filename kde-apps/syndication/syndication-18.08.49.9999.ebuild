# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_TEST="true"
inherit kde5

DESCRIPTION="Library for parsing RSS and Atom feeds"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kcodecs)
	$(add_qt_dep qtxml)
"
DEPEND="${RDEPEND}
	test? (
		$(add_qt_dep qtnetwork)
		$(add_qt_dep qtwidgets)
	)
"

src_prepare() {
	kde5_src_prepare
	if ! use test; then
		punt_bogus_dep Qt5 Network
		punt_bogus_dep Qt5 Widgets
	fi
}
