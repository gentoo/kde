# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_TYPE="tier1"
inherit kde-frameworks

DESCRIPTION="KDE item models"
KEYWORDS=""
IUSE=""

# tests are not enabled upstream due to unconverted dependencies.
# restrict to avoid issues when enabled due to missing dependencies
# etc, and as a personal reminder to check if upstream has properly
# specified all dependencies.
RESTRICT="test"
