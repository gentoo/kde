# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_PN="${PN}-1"
EGIT_REPONAME="${MY_PN}"
EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="PolKit agent module for KDE"
HOMEPAGE="http://www.kde.org"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="5"
IUSE=""

DEPEND="
	>=sys-auth/polkit-qt-0.112.0
"
RDEPEND="${DEPEND}
	!sys-auth/polkit-kde
"
