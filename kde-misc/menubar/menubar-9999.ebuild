# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="playground/base/plasma"
KMMODULE="applets/${PN}"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="A central menubar for all KDE programs"
HOMEPAGE="http://plasma.kde.org/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

RDEPEND="
	!kde-plasmoids/menubar
	$(add_kdebase_dep plasma-workspace)
"
