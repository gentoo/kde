# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Akonadi based addressbook for KDE"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	>=kde-base/akonadi-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	akonadi/kabc/
"

src_prepare() {
	kde4-meta_src_prepare

	sed -i -e 's|# macro_optional_add_subdirectory(kcontactmanager)|macro_optional_add_subdirectory(kcontactmanager)|' \
		CMakeLists.txt || die "failed to uncomment kcontactmanager"
}
