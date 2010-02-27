# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdepim"
KMMODULE="wizards"
inherit kde4-meta

DESCRIPTION="KDE PIM wizards"
IUSE="debug"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep kdepim-kresources)
	$(add_kdebase_dep libkdepim)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	kmail/
	knotes/
	kresources/groupwise/
	kresources/kolab/
	kresources/slox/
"

src_prepare() {
	ln -s "${EKDEDIR}"/include/kdepim-kresources/{kabcsloxprefs.h,kcalsloxprefs.h} \
		kresources/slox/ \
		|| die "Failed to link extra_headers."
	ln -s "${EKDEDIR}"/include/kdepim-kresources/{kabc_groupwiseprefs,kcal_groupwiseprefsbase}.h \
		kresources/groupwise/ \
		|| die "Failed to link extra_headers."
	epatch "${FILESDIR}/fix-broken-gpgme-cmake-guard.diff"

	kde4-meta_src_prepare
}
