# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmail/kmail-4.1.3.ebuild,v 1.3 2008/11/16 07:43:15 vapier Exp $

EAPI="2"

KMNAME=kdepim
inherit kde4-meta flag-o-matic toolchain-funcs

DESCRIPTION="KMail is the email component of Kontact, the integrated personal information manager of KDE."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
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

src_unpack() {
	[[ $(tc-arch) == "ppc64" ]] && append-flags -mminimal-toc #241900

	kde4-meta_src_unpack
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with nepomuk Nepomuk)"

	kde4-meta_src_configure
}
