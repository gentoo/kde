# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdepim
inherit kde4-meta

DESCRIPTION="A Personal Organizer for KDE"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook kontact"

DEPEND="app-crypt/gpgme
	>=kde-base/kdepim-kresources-${PV}:${SLOT}
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
KMEXTRACTONLY="
	kaddressbook/org.kde.KAddressbook.Core.xml
	kmail/
	knode/org.kde.knode.xml
	libkdepim
	libkholidays
"
