# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kde-baseapps"
[[ ${PV} = *9999 ]] && KMNAME="kate"
KDE_SCM="git"
inherit kde4-meta

DESCRIPTION="KDE MDI editor/IDE"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep katepart)
"
