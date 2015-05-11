# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="frameworks"
KDE_HANDBOOK="false"
inherit kde5

DESCRIPTION="Extra Dolphin plugins"
KEYWORDS=""
IUSE="bazaar dropbox git subversion"

DEPEND="
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep dolphin)
	$(add_kdeapps_dep libkonq)
	dev-qt/qtnetwork
	dev-qt/qtwidgets
"
RDEPEND="${DEPEND}
	$(add_kdeapps_dep kompare)
	bazaar? ( dev-vcs/bzr )
	dropbox? ( net-misc/dropbox-cli )
	git? ( dev-vcs/git )
	subversion? ( dev-vcs/subversion )
"

src_install() {
	{ use bazaar || use dropbox || use git || use subversion; } && kde5_src_install
}

pkg_postinst() {
	if ! use bazaar && ! use dropbox && ! use git && ! use subversion ; then
		einfo
		einfo "You have disabled all plugin use flags. If you want to have vcs"
		einfo "integration in dolphin, enable those of your needs."
		einfo
	fi
}
