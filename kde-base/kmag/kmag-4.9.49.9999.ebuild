# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE screen magnifier"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kaccessible)
"
