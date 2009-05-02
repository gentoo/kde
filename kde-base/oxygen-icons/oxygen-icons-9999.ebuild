# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="Oxygen SVG icon theme."
HOMEPAGE="http://www.oxygen-icons.org/"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/oxygen-icons"

LICENSE="LGPL-3"
KEYWORDS=""
IUSE=""

RDEPEND="
	!x11-themes/oxygen-icons
	!x11-themes/oxygen-icon-theme
"
