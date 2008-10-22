# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME=kdepim
KMNOMODULE=true
SLOT="kde-svn"
EAPI="1"
inherit kde4svn-meta

DESCRIPTION="Special Dates plugin for Kontact: displays a summary of important holidays and calendar events"
KEYWORDS=""
IUSE=""

DEPEND=">=kde-base/libkdepim-${PV}:${SLOT}
	>=kde-base/kontact-${PV}:${SLOT}
	>=kde-base/kaddressbook-${PV}:${SLOT}
	>=kde-base/korganizer-${PV}:${SLOT}
	>=kde-base/libkholidays-${PV}:${SLOT}"
RDEPEND="${DEPEND}
	>=kde-base/libkdepim-${PV}:${SLOT}"

# has to be fixed
#KMCOPYLIB="libkdepim libkdepim/
#	libkpinterfaces kontactinterfaces
#	libkaddressbook kaddressbook
#	libkorganizer_calendar korganizer
#	libkholidays libkholidays"
KMEXTRACTONLY="libkholidays
	kontactinterfaces/
	kaddressbook
	korganizer
	libkdepim"
KMEXTRA="kontact/plugins/specialdates"

src_unpack() {
	kde4svn-meta_src_unpack
	sed -e \
	's:target_link_libraries(${LINK_ARG_LIST}:target_link_libraries(${LINK_ARG_LIST}\ ${KDE4_KCAL_LIBS}:g' \
	-i "${WORKDIR}/${PN}/CMakeLists.txt" || die "linkage fix falied"

}
