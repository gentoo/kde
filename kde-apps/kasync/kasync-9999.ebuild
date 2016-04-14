# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_DOXYGEN="true"
KDE_TEST="forceoptional"
inherit kde5

DESCRIPTION="C++ library for controlling asynchronous tasks"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcoreaddons)
"
RDEPEND="${DEPEND}"
