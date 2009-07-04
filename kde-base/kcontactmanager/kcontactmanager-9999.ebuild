# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Akonadi based addressbook for KDE"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	>=kde-base/akonadi-${PV}:${SLOT}[kdeprefix=]
"

src_prepare() {
	kde4-meta_src_prepare

	sed -i -e 's|# macro_optional_add_subdirectory(kcontactmanager)|macro_optional_add_subdirectory(kcontactmanager)|' \
		CMakeLists.txt || die "failed to uncomment kcontactmanager"
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DKDEPIM_BUILD_KCONTACTMANAGER=1
	"

	kde4-meta_src_configure
}
