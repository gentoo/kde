# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="A Personal Organizer for KDE"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND="app-crypt/gpgme
	>=kde-base/libkdepim-${PV}:${SLOT}
	>=kde-base/libkholidays-${PV}:${SLOT}
	kontact? ( >=kde-base/kaddressbook-${PV}:${SLOT} )"
RDEPEND="${DEPEND}"

KMLOADLIBS="libkdepim"
KMEXTRA="kdgantt1"
if use kontact; then
	KMLOADLIBS+=" kontactinterfaces"
	KMEXTRA+=" kontact/plugins/planner"
fi

# xml targets from kmail are being uncommented by kde4-meta.eclass
KMEXTRACTONLY="kaddressbook/org.kde.KAddressbook.Core.xml
	kmail/
	knode/org.kde.knode.xml
	libkdepim
	libkholidays"

src_prepare() {
	# Fix target_link_libraries for now
	sed -i -e's/kaddressbookprivate ${KDE4_KCAL_LIBS}/${KDE4_KCAL_LIBS}/' \
		kontact/plugins/planner/CMakeLists.txt \
		|| die "Failed to remove kaddressbookprivate from link"

	kde4-meta_src_prepare
}
