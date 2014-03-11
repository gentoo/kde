# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="playground/base/plasma"
KMMODULE="applets/${PN}"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="a taskbar and quicklauncher combined"
HOMEPAGE="http://www.kdedevelopers.org/node/4038"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep plasma-workspace)
"
