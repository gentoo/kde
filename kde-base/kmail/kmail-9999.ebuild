# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KMail is the email component of Kontact, the integrated personal information manager of KDE."
KEYWORDS=""
IUSE="debug htmlhandbook +semantic-desktop"

DEPEND="
	>=kde-base/libkdepim-${PV}:${SLOT}
	>=kde-base/libkleo-${PV}:${SLOT}
	>=kde-base/libkpgp-${PV}:${SLOT}
	>=kde-base/libksieve-${PV}:${SLOT}
	>=kde-base/mimelib-${PV}:${SLOT}
	semantic-desktop? ( >=kde-base/nepomuk-${PV}:${SLOT} )
"
RDEPEND="${DEPEND}
	>=kde-base/kmailcvt-${PV}:${SLOT}
"

KMEXTRACTONLY="
	kaddressbook/org.kde.KAddressbook.Core.xml
	korganizer/org.kde.Korganizer.Calendar.xml
	libkdepim
	libkleo
	libkpgp
	libksieve
	mimelib
"
KMEXTRA="
	plugins/kmail/
"
KMLOADLIBS="libkdepim"

PATCHES=( "${FILESDIR}/${PN}-4.1.72-fix.patch" )

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with semantic-desktop Nepomuk)"

	MAKEOPTS="${MAKEOPTS} -j1"

	kde4-meta_src_configure
}
