# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdepim
inherit kde4svn-meta

DESCRIPTION="A Personal Organizer for KDE"
KEYWORDS=""
IUSE="debug htmlhandbook"

DEPEND="app-crypt/gpgme
	>=kde-base/libkdepim-${PV}:${SLOT}
	>=kde-base/libkholidays-${PV}:${SLOT}
	kontact? ( >=kde-base/kaddressbook-${PV}:${SLOT} )"
	#>=kde-base/kdepim-kresources-${PV}:${SLOT}
RDEPEND="${DEPEND}"

KMLOADLIBS="libkdepim"
use kontact && KMLOADLIBS+=" kontactinterfaces"

KMEXTRA="kdgantt1"
use kontact && KMEXTRA+=" kontact/plugins/planner"

# xml targets from kmail are being uncommented by kde4overlay-meta.eclass
KMEXTRACTONLY="kaddressbook/org.kde.KAddressbook.Core.xml
	kmail/
	knode/org.kde.knode.xml
	libkdepim
	libkholidays"
