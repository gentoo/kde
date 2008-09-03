# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdepim
KMMODULE=wizards
inherit kde4-meta

DESCRIPTION="KDEPIM wizards"
IUSE="debug"
KEYWORDS="~amd64 ~x86"

DEPEND="app-crypt/gpgme:1
	kde-base/kdepim-kresources:${SLOT}
	kde-base/libkdepim:${SLOT}"

KMEXTRACTONLY="
	kmail
	knotes
	kresources/egroupware
	kresources/kolab
	kresources/scalix
	kresources/slox
	libkdepim
"
# groupwise is disabled on CMakeLists.txt
#	kresources/groupwise

src_unpack() {
	kde4-meta_src_unpack

	pushd "${WORKDIR}"/${P}/kresources/egroupware
	# create the kabc_egroupware.h, kcal_egroupware.h and knotes_egroupware.h files
	kconfig_compiler kresources_kabc_egroupware.kcfg kabc_egroupwareprefs.kcfgc
	kconfig_compiler kresources_kcal_egroupware.kcfg kcal_egroupwareprefs.kcfgc
	kconfig_compiler kresources_knotes_egroupware.kcfg knotes_egroupwareprefs.kcfgc
	popd

	pushd "${WORKDIR}"/${P}/kresources/slox
	# create the kabcsloxprefs.h, kcalsloxprefs.h and knotessloxprefs.h files
	kconfig_compiler kresources_kabc_slox.kcfg kabcsloxprefs.kcfgc
	kconfig_compiler kresources_kcal_slox.kcfg kcalsloxprefs.kcfgc
	popd

}
