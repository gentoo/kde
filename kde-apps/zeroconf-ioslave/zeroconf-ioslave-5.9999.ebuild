# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="DNSSD (DNS Service Discovery - part of Rendezvous) ioslave and kded module"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdnssd)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	dev-qt/qtdbus:5
"

RDEPEND="${DEPEND}"
