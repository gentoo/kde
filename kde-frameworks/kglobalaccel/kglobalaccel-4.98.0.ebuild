# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Framework to handle global shortcuts"
KEYWORDS=" ~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="LGPL-2+"
IUSE="X"

DEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtwidgets:5
	X? ( dev-qt/qtx11extras:5 )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package X X11)
	)

	kde-frameworks_src_configure
}
