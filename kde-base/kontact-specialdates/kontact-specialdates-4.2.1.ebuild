# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kontact-specialdates/kontact-specialdates-4.2.0.ebuild,v 1.3 2009/02/06 00:08:26 ranger Exp $

EAPI="2"

KMNAME="kdepim"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="Special Dates plugin for Kontact: displays a summary of important holidays and calendar events"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

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
	# Fix target_link_libraries for now
	sed -i -e's/korganizer_calendar kaddressbookprivate)/korganizer_calendar)/' \
		kontact/plugins/specialdates/CMakeLists.txt \
		|| die "Failed to remove kaddressbookprivate from link"

	kde4-meta_src_prepare
}
