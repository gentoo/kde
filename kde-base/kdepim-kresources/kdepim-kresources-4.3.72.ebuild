# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
KMMODULE="kresources"
inherit kde4-meta

DESCRIPTION="KDE PIM groupware plugin collection"
IUSE="debug"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"

DEPEND="
	$(add_kdebase_dep libkdepim)
	$(add_kdebase_dep kaddressbook)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	kmail/
	knotes/
	korganizer/version.h
"

KMLOADLIBS="libkdepim"

src_prepare() {
	#local kconfig_compiler="${KDEDIR}/bin/kconfig_compiler"

	#pushd kaddressbook/common
	# create the kabprefs_base.h file
	#${kconfig_compiler} kaddressbook.kcfg kabprefs_base.kcfgc
	#popd

	kde4-meta_src_prepare
}

src_install() {
	kde4-meta_src_install

	# Install headers needed by kdepim-wizards, egroupware stuff gone
	insinto "${PREFIX}"/include/${PN}
	doins "${CMAKE_BUILD_DIR}"/${KMMODULE}/{groupwise,slox}/*.h || \
			die "Failed to install extra header files"
}
