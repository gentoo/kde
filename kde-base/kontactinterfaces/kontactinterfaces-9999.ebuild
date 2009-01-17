# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Interfaces for Kontact"
KEYWORDS=""
IUSE="debug"

DEPEND="
	kde-base/libkdepim:${SLOT}
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	kaddressbook/org.kde.KAddressbook.Core.xml
	korganizer/korgac/org.kde.korganizer.KOrgac.xml
"
KMCOMPILEONLY="
	libkdepim
"

KMSAVELIBS="true"
