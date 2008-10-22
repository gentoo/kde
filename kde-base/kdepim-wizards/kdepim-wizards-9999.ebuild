# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdepim
KMMODULE=wizards
inherit kde4svn-meta

DESCRIPTION="KDEPIM wizards"
IUSE="debug"
KEYWORDS=""

DEPEND="app-crypt/gpgme:1
	kde-base/kdepim-kresources:${SLOT}
	kde-base/libkdepim:${SLOT}"

KMEXTRACTONLY="knotes
	kmail
	kresources/egroupware
	kresources/groupwise
	kresources/kolab
	kresources/scalix
	kresources/slox
	libkdepim"

src_unpack() {
	kde4svn-meta_src_unpack

	ln -s "${PREFIX}"/include/kdepim-kresources/{kabc,kcal,knotes}_egroupwareprefs.h \
		"${WORKDIR}"/${PN}/kresources/egroupware/ \
		|| die "Failed to link extra_headers."
	ln -s "${PREFIX}"/include/kdepim-kresources/{kabcsloxprefs.h,kcalsloxprefs.h} \
		"${WORKDIR}"/${PN}/kresources/slox/ \
		|| die "Failed to link extra_headers."
	ln -s "${PREFIX}"/include/kdepim-kresources/{kabc_groupwiseprefs,kcal_groupwiseprefsbase}.h \
		"${WORKDIR}"/${PN}/kresources/groupwise/ \
		|| die "Failed to link extra_headers."
}
