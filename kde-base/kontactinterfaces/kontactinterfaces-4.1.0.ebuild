# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdepim
inherit kde4-meta

DESCRIPTION="Interfaces library for the KDE personal information manager"
KEYWORDS="~amd64"
IUSE="debug htmlhandbook"

#PATCHES=("${FILESDIR}/${PN}-as-needed.patch")

KMSAVELIBS="true"

KMEXTRACTONLY="kaddressbook/org.kde.KAddressbook.Core.xml
	korganizer/korgac/org.kde.korganizer.KOrgac.xml"
KMCOMPILEONLY="libkdepim"
