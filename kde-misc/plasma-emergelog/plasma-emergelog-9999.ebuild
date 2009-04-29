# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base git

DESCRIPTION="Kde4 plasmoid for monitoring emerge progress on Gentoo Linux"
HOMEPAGE="http://github.com/hwoarang/plasma-emergelog/tree/master"
EGIT_REPO_URI="git://github.com/hwoarang/plasma-emergelog.git"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

RDEPEND="
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
"

pkg_postinst() {
	kde4-base_pkg_postinst
	einfo "You need to add your user to 'portage' group"
	einfo "in order to use this plasmoid. To do that, use"
	einfo "the following command:"
	einfo "usermod -a -G portage <your_user_here>"
}
