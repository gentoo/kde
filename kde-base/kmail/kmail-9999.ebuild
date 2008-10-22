# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdepim
inherit kde4svn-meta

DESCRIPTION="KMail is the email component of Kontact, the integrated personal information manager of KDE."
KEYWORDS=""
IUSE="debug htmlhandbook nepomuk"

DEPEND=">=kde-base/libkdepim-${PV}:${SLOT}
	>=kde-base/libkleo-${PV}:${SLOT}
	>=kde-base/libkpgp-${PV}:${SLOT}
	>=kde-base/libksieve-${PV}:${SLOT}
	>=kde-base/mimelib-${PV}:${SLOT}
	nepomuk? ( >=kde-base/nepomuk-${PV}:${SLOT} )"

RDEPEND="${DEPEND}
	>=kde-base/kmailcvt-${PV}:${SLOT}"

KMEXTRACTONLY="kaddressbook/org.kde.KAddressbook.Core.xml
	korganizer/org.kde.Korganizer.Calendar.xml
	libkdepim
	libkleo
	libkpgp
	mimelib"
KMEXTRA="${KMEXTRA} plugins/kmail/"
KMLOADLIBS="libkdepim"

src_unpack() {
	kde4svn-meta_src_unpack

}

src_compile() {
	# not really sure what INDEXLIB does. if it turns out to be useful it should
	# either be enabled or have a use flag.. :p
	mycmakeargs="${mycmakeargs}
		-DWITH_INDEXLIB=OFF
		$(cmake-utils_use_with nepomuk Nepomuk)"

	MAKEOPTS="${MAKEOPTS} -j1"

	kde4overlay-meta_src_compile
}
