# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kdepim"
KMMODULE="kresources"
inherit kde4-meta

DESCRIPTION="KDE PIM groupware plugin collection (noakonadi branch)"
IUSE="debug"
KEYWORDS=""

DEPEND="
	$(add_kdebase_dep kdepimlibs '' 4.6)
	$(add_kdebase_dep libkdepim '' 4.4.2015)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	kmail/
	knotes/
	korganizer/version.h
	kaddressbook/common/kabprefs.h
"

KMLOADLIBS="libkdepim"

src_install() {
	kde4-meta_src_install

	# Install headers needed by kdepim-wizards, egroupware stuff gone
	insinto "${PREFIX}"/include/${PN}
	doins "${CMAKE_BUILD_DIR}"/${KMMODULE}/{groupwise,slox}/*.h
}
