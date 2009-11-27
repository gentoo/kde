# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
KMMODULE="wizards"
inherit kde4-meta

DESCRIPTION="KDE PIM wizards"
IUSE="debug"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"

DEPEND="
	app-crypt/gpgme:1
	$(add_kdebase_dep kdepim-kresources)
	$(add_kdebase_dep libkdepim)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	kmail/
	knotes/
	kresources/egroupware/
	kresources/groupwise/
	kresources/kolab/
	kresources/scalix/
	kresources/slox/
"

src_prepare() {
	ln -s "${PREFIX}"/include/kdepim-kresources/{kabc,kcal,knotes}_egroupwareprefs.h \
		kresources/egroupware/ \
		|| die "Failed to link extra_headers."
	ln -s "${PREFIX}"/include/kdepim-kresources/{kabcsloxprefs.h,kcalsloxprefs.h} \
		kresources/slox/ \
		|| die "Failed to link extra_headers."
	ln -s "${PREFIX}"/include/kdepim-kresources/{kabc_groupwiseprefs,kcal_groupwiseprefsbase}.h \
		kresources/groupwise/ \
		|| die "Failed to link extra_headers."

	kde4-meta_src_prepare
}
