# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdepim/libkdepim-4.4.11.1-r1.ebuild,v 1.10 2014/04/05 18:11:45 dilfridge Exp $

EAPI=5

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Common library for KDE PIM apps (noakonadi branch)"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs '' 4.6)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	korganizer/korgac/org.kde.korganizer.KOrgac.xml
	kaddressbook/org.kde.KAddressbook.Core.xml
"

KMSAVELIBS="true"

# the one test that can be run requires a dbus session bus
RESTRICT=test

src_install() {
	kde4-meta_src_install

	# install additional generated headers that are needed by other packages that
	# are derived from kdepim. e.g. kmail.
	pushd "${CMAKE_BUILD_DIR}/libkdepim/" 2>/dev/null || die "pushd libkdepim failed"
	insinto "${PREFIX}/include"
	doins ui_addresspicker.h ui_categoryselectdialog_base.h || die "Failed to install extra header files."
	popd 2>/dev/null
}
