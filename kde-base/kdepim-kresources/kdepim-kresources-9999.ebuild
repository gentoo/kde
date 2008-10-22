# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdepim
KMMODULE=kresources
inherit kde4svn-meta

DESCRIPTION="KDE PIM groupware plugin collection"
IUSE="debug"
KEYWORDS=""

DEPEND="kde-base/akonadi:${SLOT}
	kde-base/kaddressbook:${SLOT}
	kde-base/knotes:${SLOT}
	kde-base/libkdepim:${SLOT}"

KMEXTRACTONLY="akonadi/kcal/
	kaddressbook/common/
	kmail/
	knotes/
	korganizer/version.h
	libkdepim/"
KMLOADLIBS="libkdepim"

src_unpack() {
	kde4svn-meta_src_unpack

	ln -s "${PREFIX}"/include/kaddressbook/kabprefs_base.h \
		"${WORKDIR}"/${PN}/kaddressbook/common/kabprefs_base.h \
		|| die "linking extra generated header into sources failed"

	# if kdepim_export.h exists it tries to use kxml_compiler from the sources. this isn't desired
	# as we don't compile kresources together with kode (kxml_compiler). we still need the header though.
	sed -i -e 's/kdepim_export.h/&_DONOTFIND/' "${WORKDIR}"/${PN}/cmake/modules/FindKode.cmake || die "sed failed"
}

src_install() {
	kde4overlay-meta_src_install

	# Install headers needed by kdepim-wizards
	insinto "${PREFIX}"/include/${PN}
	doins "${WORKDIR}"/${PN}_build/${KMMODULE}/{groupwise,egroupware,slox}/*.h || \
			die "Failed to install extra header files"
}
