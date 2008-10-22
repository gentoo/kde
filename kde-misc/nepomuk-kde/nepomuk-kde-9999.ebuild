# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME="playground/base"
KMMODULE="nepomuk-kde"

NEED_KDE="svn"
SLOT="kde-svn"

inherit kde4svn-meta

DESCRIPTION="Extra Nepomuk tools."
HOMEPAGE="http://nepomuk.kde.org/"

KEYWORDS=""
IUSE=""
LICENSE="GPL-2 LGPL-2"
PREFIX="${KDEDIR}"

DEPEND="
	>=app-misc/strigi-0.5.11
	dev-libs/soprano
	kde-base/nepomuk
	kde-base/libplasma"
RDEPEND="${DEPEND}"

# Restrict the tests for now.
RESTRICT="test"

src_compile() {
	sed -e "/MacroOptionalAddSubdirectory/ c\add_subdirectory( ${PN} )" \
		-i "${S}"/CMakeLists.txt || die "Adding ${PN} failed."
	sed -e '/pimoshell/ s:^:#DONOTWANT:' \
		-i "${S}"/${PN}/CMakeLists.txt || die "Deactivating pimoshell failed."

	kde4overlay-base_src_compile
}

src_install() {
        cmake-utils_src_install
	rm "${D}"/usr/kde/svn/lib64/kde4/kio_nepomuksearch.so
	rm "${D}"/usr/kde/svn/share/kde4/services/nepomuksearch.protocol
}
