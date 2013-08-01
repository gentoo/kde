# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-2

DESCRIPTION="PolicyKit Qt4 API wrapper library."
HOMEPAGE="http://kde.org/"
EGIT_REPO_URI="git://anongit.kde.org/polkit-qt-1"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug examples"

RDEPEND="
	dev-libs/glib:2
	dev-qt/qtcore:4[glib]
	dev-qt/qtdbus:4
	dev-qt/qtgui:4[glib]
	>=sys-auth/polkit-0.103
"
DEPEND="${RDEPEND}
	dev-util/automoc
"

DOCS=( AUTHORS README README.porting TODO )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build examples)
	)
	cmake-utils_src_configure
}
