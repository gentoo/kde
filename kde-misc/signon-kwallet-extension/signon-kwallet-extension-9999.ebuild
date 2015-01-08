# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

SLOT="0"
DESCRIPTION="KWallet extension for signond"
HOMEPAGE="https://01.org/gsso/"

KEYWORDS=""
LICENSE="LGPL-2.1"

DEPEND="
	$(add_frameworks_dep kwallet)
	dev-qt/qtcore:5
	net-libs/signond
"
RDEPEND="${DEPEND}"
