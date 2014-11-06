# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-frameworks/kauth/kauth-5.3.0.ebuild,v 1.1 2014/10/15 13:29:46 kensington Exp $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Framework to let applications perform actions as a privileged user"
LICENSE="LGPL-2.1+"
KEYWORDS=" ~amd64"
IUSE="nls +policykit"

RDEPEND="
	$(add_frameworks_dep kcoreaddons)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	policykit? ( sys-auth/polkit-qt[qt5] )
"
DEPEND="${RDEPEND}
	nls? ( dev-qt/linguist-tools:5 )
"
#PDEPEND="policykit? ( sys-auth/polkit-kde-agent )"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package policykit PolkitQt-1)
	)

	kde5_src_configure
}
