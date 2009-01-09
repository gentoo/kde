# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-wizards/kdepim-wizards-4.1.3.ebuild,v 1.2 2008/11/16 07:24:54 vapier Exp $

EAPI="2"

KMNAME=kdepim
KMMODULE=wizards
inherit kde4-meta

DESCRIPTION="KDEPIM wizards"
IUSE="debug"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

DEPEND="app-crypt/gpgme:1
	kde-base/kdepim-kresources:${SLOT}
	kde-base/libkdepim:${SLOT}"

KMEXTRACTONLY="
	kmail
	knotes
	kresources/egroupware
	kresources/groupwise
	kresources/kolab
	kresources/scalix
	kresources/slox
	libkdepim
"

src_unpack() {
	local kconfig_compiler="${KDEDIR}/bin/kconfig_compiler"

	kde4-meta_src_unpack

	pushd "${WORKDIR}"/${P}/kresources/egroupware
	# create the kabc_egroupware.h, kcal_egroupware.h and knotes_egroupware.h files
	${kconfig_compiler} kresources_kabc_egroupware.kcfg kabc_egroupwareprefs.kcfgc
	${kconfig_compiler} kresources_kcal_egroupware.kcfg kcal_egroupwareprefs.kcfgc
	${kconfig_compiler} kresources_knotes_egroupware.kcfg knotes_egroupwareprefs.kcfgc
	popd

	pushd "${WORKDIR}"/${P}/kresources/slox
	# create the kabcsloxprefs.h, kcalsloxprefs.h and knotessloxprefs.h files
	${kconfig_compiler} kresources_kabc_slox.kcfg kabcsloxprefs.kcfgc
	${kconfig_compiler} kresources_kcal_slox.kcfg kcalsloxprefs.kcfgc
	popd

	pushd "${WORKDIR}"/${P}/kresources/groupwise
	#create the kabc_groupwiseprefs.h and kcal_groupwiseprefsbase.h
	${kconfig_compiler} kresources_kabc_groupwise.kcfg kabc_groupwiseprefs.kcfgc
	${kconfig_compiler} kresources_kcal_groupwise.kcfg kcal_groupwiseprefsbase.kcfgc
	popd
}
