# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdebase-runtime
inherit kde4svn-meta

DESCRIPTION="Nepomuk KDE4 client"
KEYWORDS=""
IUSE="debug"

# dev-cpp/clucene provides the optional strigi backend.
# As there's currently no other *usable* strigi backend, I've added it as a hard
# dependency.
DEPEND=">app-misc/strigi-0.5.11
		dev-cpp/clucene
		>=dev-libs/soprano-2.0.98
		kde-base/kdelibs:${SLOT}"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ! built_with_use app-misc/strigi qt4 ; then
		eerror "Need app-misc/strigi with USE=qt4 enabled"
		die
	fi

	if ! built_with_use dev-libs/soprano clucene ; then
		eerror "dev-libs/soprano needs to be built with the clucene USE flag enabled"
		die
	fi

	if ! built_with_use kde-base/kdelibs semantic-desktop ; then
		eerror "strigi requires kdelibs be built with USE=semantic-desktop"
		die
	fi
}
