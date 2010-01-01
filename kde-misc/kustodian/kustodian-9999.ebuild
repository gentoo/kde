# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="playground/base/plasma"
KMMODULE="applets/${PN}"
inherit kde4-meta

DESCRIPTION="a taskbar and quicklauncher combined"
HOMEPAGE="http://www.kdedevelopers.org/node/4038"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

RDEPEND="
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
"
