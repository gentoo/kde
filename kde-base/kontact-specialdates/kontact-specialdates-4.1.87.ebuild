# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="Special Dates plugin for Kontact: displays a summary of important holidays and calendar events"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=kde-base/libkdepim-${PV}:${SLOT}
	>=kde-base/kontact-${PV}:${SLOT}
	>=kde-base/kaddressbook-${PV}:${SLOT}
	>=kde-base/korganizer-${PV}:${SLOT}
	>=kde-base/libkholidays-${PV}:${SLOT}"
RDEPEND="${DEPEND}
	>=kde-base/libkdepim-${PV}:${SLOT}"
KMEXTRACTONLY="libkholidays
	kontactinterfaces/
	kaddressbook
	korganizer
	libkdepim"
KMEXTRA="kontact/plugins/specialdates"

src_prepare() {
	sed -e \
		's:target_link_libraries(${LINK_ARG_LIST}:target_link_libraries(${LINK_ARG_LIST}\ ${KDE4_KCAL_LIBS}:g' \
		-i CMakeLists.txt || die "linkage fix falied"

	kde4-meta_src_prepare
}
