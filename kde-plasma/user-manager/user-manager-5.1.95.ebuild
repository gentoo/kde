# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="A simple system settings module to manage the users of your system"
LICENSE="GPL-2"
KEYWORDS=" ~amd64"
IUSE=""

DEPEND="
	$(add_frameworks_dep kdelibs4support)
	dev-libs/libpwquality
"
RDEPEND="${DEPEND}
"
