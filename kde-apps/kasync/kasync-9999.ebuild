# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_TEST=true
inherit kde5

DESCRIPTION="C++ library for controlling asynchronous tasks"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcoreaddons)
"
RDEPEND="${DEPEND}"
