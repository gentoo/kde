# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdeaccessibility
inherit kde4svn-meta

DESCRIPTION="KDE accessibility tool: translates mouse hovering into clicks"
KEYWORDS=""
IUSE="debug htmlhandbook"

RDEPEND="
	>=kde-base/knotify-${PV}:${SLOT}
	media-sound/phonon"
