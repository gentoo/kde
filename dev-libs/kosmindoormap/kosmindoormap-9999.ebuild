# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
PVCUT=$(ver_cut 1-3)
KFMIN=5.248.0
QTMIN=6.6.0
inherit ecm gear.kde.org

DESCRIPTION="Data Model and Extraction System for Travel Reservation information"
HOMEPAGE="https://invent.kde.org/libraries/kosmindoormap"

LICENSE="LGPL-2+"
SLOT="6"
KEYWORDS=""
IUSE="+openinghours"

RDEPEND="
	>=dev-libs/kpublictransport-${PVCUT}:6
	dev-libs/protobuf:=
	>=dev-qt/qtbase-${QTMIN}:6[gui,network]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	sys-libs/zlib
	openinghours? ( >=dev-libs/kopeninghours-${PVCUT}:6 )
"
DEPEND="${RDEPEND}
	test? ( >=dev-qt/qtbase-${QTMIN}:6[widgets] )
"
BDEPEND="
	app-alternatives/lex
	app-alternatives/yacc
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_OsmTools=ON # we have no use for it
		$(cmake_use_find_package openinghours KOpeningHours)
	)
	ecm_src_configure
}
