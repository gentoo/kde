# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kde-workspace"
CPPUNIT_REQUIRED="test"
inherit kde4-meta

DESCRIPTION="KDE control module for Solid actions"
HOMEPAGE="http://solid.kde.org"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep solid-runtime)
	!kde-base/solid:4
"
