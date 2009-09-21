# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="Special Dates plugin for Kontact: displays a summary of important holidays and calendar events"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	>=kde-base/libkdepim-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}
	>=kde-base/kaddressbook-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/korganizer-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kontact-${PV}:${SLOT}[kdeprefix=]
"

KMEXTRACTONLY="
	kaddressbook
	korganizer
"
KMEXTRA="
	kontact/plugins/specialdates/
"

src_prepare() {
	# Fix target_link_libraries for now
	sed -i -e's/korganizer_calendar kaddressbookprivate)/korganizer_calendar)/' \
		kontact/plugins/specialdates/CMakeLists.txt \
		|| die "Failed to remove kaddressbookprivate from link"

	kde4-meta_src_prepare
}
