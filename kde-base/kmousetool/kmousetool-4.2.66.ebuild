# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeaccessibility"
inherit kde4-meta

DESCRIPTION="KDE accessibility tool: translates mouse hovering into clicks"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	>=kde-base/knotify-${PV}:${SLOT}[kdeprefix=]
"
