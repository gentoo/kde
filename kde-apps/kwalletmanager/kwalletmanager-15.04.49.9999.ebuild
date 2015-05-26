# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE Wallet Management Tool"
HOMEAGE="http://www.kde.org/applications/system/kwalletmanager
http://utils.kde.org/projects/kwalletmanager"
KEYWORDS=""
IUSE="debug minimal"

RDEPEND="!kde-base/kwallet:4"

src_install() {
	kde4-base_src_install

	if use minimal ; then
		rm -r "${D}"/usr/share/icons
	fi
}
