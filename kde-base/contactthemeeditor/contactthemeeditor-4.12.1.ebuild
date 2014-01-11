# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="A contact theme editor for KAddressBook"
HOMEPAGE="http://www.kde.org/"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kaddressbook)
"
RDEPEND="${DEPEND}"

KMCOMPILEONLY="
	kaddressbookgrantlee/
	grantleetheme/
"
KMEXTRACTONLY="
	grantleethemeeditor/
	pimcommon/
"

KMLOADLIBS="kdepim-common-libs"
