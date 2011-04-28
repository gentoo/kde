# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="extragear/base"
inherit kde4-meta

DESCRIPTION="KDE tool that looks for well-known apps in your path and creates entries for them in the KDE menu"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug +handbook"

RDEPEND="
	!kde-base/kappfinder[-kdeprefix]
"
