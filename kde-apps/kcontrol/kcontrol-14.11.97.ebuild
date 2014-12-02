# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="The KDE Control Center"
KEYWORDS=" ~amd64 ~x86"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep khotkeys '' 4.11)
	$(add_kdeapps_dep zeroconf-ioslave)
"
