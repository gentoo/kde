# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME=kdepim
inherit kde4-meta

DESCRIPTION="KMail is the email component of Kontact, the integrated personal information manager of KDE."
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook +nepomuk"

DEPEND=">=kde-base/libkdepim-${PV}:${SLOT}
	>=kde-base/libkleo-${PV}:${SLOT}
	>=kde-base/libkpgp-${PV}:${SLOT}
	>=kde-base/libksieve-${PV}:${SLOT}
	>=kde-base/mimelib-${PV}:${SLOT}
	nepomuk? ( >=kde-base/nepomuk-${PV}:${SLOT} )"

RDEPEND="${DEPEND}
	>=kde-base/kmailcvt-${PV}:${SLOT}"

KMEXTRACTONLY="
	libkdepim
	libkleo
	libkpgp
	kaddressbook/org.kde.KAddressbook.Core.xml
	korganizer/org.kde.Korganizer.Calendar.xml
	mimelib
	kdepim-compat.h
"
KMEXTRA="${KMEXTRA} plugins/kmail/"
KMLOADLIBS="libkdepim"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with nepomuk Nepomuk)"

	kde4-meta_src_configure
}
