# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Common library for KDE PIM apps"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=kde-base/akonadi-${PV}:${SLOT}[kdeprefix=]
"

# @Since >4.2.65 kode removed from kdepim
RDEPEND="${DEPEND}
	!kdeprefix? ( !>=kde-base/kode-4.1.0[-kdeprefix] )
	kdeprefix? ( !kde-base/kode:${SLOT} )
"

KMEXTRACTONLY="
	akonadi/contact/
	korganizer/korgac/org.kde.korganizer.KOrgac.xml
"

KMSAVELIBS="true"

PATCHES=( "${FILESDIR}"/${PN}-fix-link.patch )

src_install() {
	kde4-meta_src_install

	# install additional generated headers that are needed by other packages that
	# are derived from kdepim. e.g. kmail.
	pushd "${CMAKE_BUILD_DIR}/libkdepim/" 2>/dev/null || die "pushd libkdepim failed"
	insinto "${PREFIX}/include"
	doins ui_addresspicker.h ui_categoryselectdialog_base.h || die "Failed to install extra header files."
	popd 2>/dev/null
}
