# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="Applications/14.12"
inherit kde4-base

DESCRIPTION="KDE library to compare files and strings"
KEYWORDS=""
IUSE="debug test"

RDEPEND="${DEPEND}
	!<=kde-base/kompare-4.11.50
"
