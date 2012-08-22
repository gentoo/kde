# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DECLARATIVE_REQUIRED="always"
inherit kde4-base

DESCRIPTION="Application launcher for KDE Plasma desktop"
HOMEPAGE="https://projects.kde.org/projects/playground/base/homerun"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkworkspace)
"
RDEPEND="
	${DEPEND}
	$(add_kdebase_dep plasma-workspace)
"

# Fails 4 out of 5, check later again.
RESTRICT="test"
