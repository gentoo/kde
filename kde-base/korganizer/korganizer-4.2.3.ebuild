# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/korganizer/korganizer-4.2.2.ebuild,v 1.2 2009/04/17 06:17:04 alexxy Exp $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="A Personal Organizer for KDE"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug doc"

DEPEND="
	app-crypt/gpgme
	>=kde-base/libkdepim-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkholidays-${PV}:${SLOT}[kdeprefix=]
	kontact? ( >=kde-base/kaddressbook-${PV}:${SLOT}[kdeprefix=] )
"
RDEPEND="${DEPEND}
	>=kde-base/ktimezoned-${PV}:${SLOT}[kdeprefix=]
"

KMLOADLIBS="libkdepim"
KMEXTRA="kdgantt1"

# xml targets from kmail are being uncommented by kde4-meta.eclass
KMEXTRACTONLY="
	kaddressbook/org.kde.KAddressbook.Core.xml
	kmail/
	knode/org.kde.knode.xml
	libkholidays
"

src_unpack() {
	if use kontact; then
		KMLOADLIBS="${KMLOADLIBS} kontactinterfaces"
		KMEXTRA="${KMEXTRA} kontact/plugins/planner"
	fi

	kde4-meta_src_unpack
}

src_prepare() {
	if use kontact; then
		# Fix target_link_libraries for now
		sed -i -e's/kaddressbookprivate ${KDE4_KCAL_LIBS}/${KDE4_KCAL_LIBS}/' \
			kontact/plugins/planner/CMakeLists.txt \
			|| die "Failed to remove kaddressbookprivate from link"
	fi

	kde4-meta_src_prepare
}
