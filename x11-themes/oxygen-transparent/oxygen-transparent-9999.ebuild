# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/oxygen-gtk/oxygen-gtk-1.1.6.ebuild,v 1.1 2011/12/15 16:28:49 johu Exp $

EAPI=4

KDE_SCM="git"
if use !experimental; then
	EGIT_BRANCH="stable"
fi
EGIT_REPONAME="oxygen-transparent"
inherit kde4-base

DESCRIPTION="Oxygen style and decoration with support for transparency"
HOMEPAGE="https://projects.kde.org/projects/playground/artwork/oxygen-transparent"

LICENSE="as-is"
KEYWORDS=""
SLOT="0"
IUSE="experimental debug"

RDEPEND="
	x11-libs/libX11
"
DEPEND="${RDEPEND}
	$(add_kdebase_dep kwin)
"
