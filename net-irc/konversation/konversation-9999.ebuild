# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="frameworks"
KDE_NLS="true"
inherit kde5

DESCRIPTION="A user friendly IRC Client for KDE"
HOMEPAGE="http://kde.org/applications/internet/konversation/ http://konversation.kde.org"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="+crypt"

RDEPEND="
	crypt? ( app-crypt/qca:2[qt5] )
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with crypt QCA2)
	)

	kde5_src_configure
}
