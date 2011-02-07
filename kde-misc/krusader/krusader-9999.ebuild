# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE with many extras."
HOMEPAGE="http://www.krusader.org/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"


RDEPEND=">=kde-base/libkonq-${KDE_MINIMAL}"
DEPEND="${RDEPEND}
	sys-devel/gettext
"
