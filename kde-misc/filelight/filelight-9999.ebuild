# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdereview"
inherit kde4-meta

DESCRIPTION="Filelight creates an interactive map of concentric, segmented rings that help visualise disk usage."
HOMEPAGE="http://kde-apps.org/content/show.php/filelight?content=99561"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug +handbook"

RDEPEND="
	!kde-misc/filelight:0
	x11-apps/xdpyinfo
"
