# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde4-base

DESCRIPTION="KDE4 plasmoid for monitoring emerge progress on Gentoo Linux"
HOMEPAGE="https://github.com/gentoo/plasma-emergelog"
EGIT_REPO_URI="https://github.com/gentoo/${PN}"

LICENSE="GPL-3+"
# Included LICENSE is GPL-2, but all headers say 3+. hwoarang said 
# that it can be licensed as 3+
KEYWORDS=""
SLOT="4"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep plasma-workspace)
"

pkg_postinst() {
	kde4-base_pkg_postinst
	einfo "You need to add your user to 'portage' group"
	einfo "in order to use this plasmoid. To do that, use"
	einfo "the following command:"
	einfo "usermod -a -G portage <your_user_here>"
}
