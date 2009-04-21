# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base git

DESCRIPTION="Kde4 plasmoid for monitoring emerge progress on Gentoo Linux"
HOMEPAGE="http://github.com/hwoarang/plasma-emergelog/tree/master"
EGIT_REPO_URI="git://github.com/hwoarang/plasma-emergelog.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="debug"
RDEPEND=">=kde-base/plasma-workspace-${KDE_MINIMAL}"
DOCS="README AUTHORS"
