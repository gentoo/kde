# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Common library for KDE PIM apps"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs 'akonadi')
"
RDEPEND="${DEPEND}"

# @Since >4.2.65 kode removed from kdepim
add_blocker kode

# Only parts of kmail are used, see src_prepare
KMEXTRA="
	kmail
	libkdepimdbusinterfaces
"

KMEXTRACTONLY="
	korganizer/korgac/org.kde.korganizer.KOrgac.xml
	korganizer/org.kde.korganizer.Korganizer.xml
	knode/org.kde.knode.xml
"

KMSAVELIBS="true"

src_prepare() {
	kde4-meta_src_prepare

	sed -n -e '/qt4_generate_dbus_interface(.*org\.kde\.kmail\.\(kmail\|mailcomposer\)\.xml/p' \
		-e '/add_custom_target(kmail_xml /,/)/p' \
		-i kmail/CMakeLists.txt || die "uncommenting xml failed"
}

src_install() {
	kde4-meta_src_install

	# install additional generated headers that are needed by other packages that
	# are derived from kdepim. e.g. kmail.
	pushd "${CMAKE_BUILD_DIR}/libkdepim/" 2>/dev/null || die "pushd libkdepim failed"
	insinto "${PREFIX}/include"
	doins ui_addresspicker.h ui_categoryselectdialog_base.h || die "Failed to install extra header files."
	popd 2>/dev/null
}
