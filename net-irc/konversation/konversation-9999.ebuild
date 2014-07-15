# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="A user friendly IRC Client for KDE"
HOMEPAGE="http://konversation.kde.org"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="+crypt"

DEPEND="
	crypt? ( app-crypt/qca:2 )
"
RDEPEND="${DEPEND}
	crypt? ( app-crypt/qca-ossl )
"

src_configure() {
	mycmakeargs+=(
		$(cmake-utils_use_with crypt QCA2)
	)
	kde5_src_configure
}
