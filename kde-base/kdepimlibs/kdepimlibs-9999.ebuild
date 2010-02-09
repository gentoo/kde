# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

CPPUNIT_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="Common library for KDE PIM apps."
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
LICENSE="LGPL-2.1"
IUSE="+akonadi debug +handbook ldap"

# some akonadi tests timeout, that probaly needs more work as its ~700 tests
RESTRICT="test"

DEPEND="
	>=app-crypt/gpgme-1.1.6
	>=dev-libs/boost-1.35.0-r5
	dev-libs/libgpg-error
	>=dev-libs/libical-0.43
	dev-libs/cyrus-sasl
	akonadi? ( >=app-office/akonadi-server-1.3.1 )
	ldap? ( net-nds/openldap )
"
RDEPEND="${DEPEND}"

# libakonadi-kcal moved here from akonadi in 4.3.86
add_blocker akonadi '<4.3.86'
# @since 4.3 - libkholidays is in kdepimlibs now
add_blocker libkholidays
# @since 4.4 - kontactinterfaces is in kdepimlibs now
add_blocker kontactinterfaces

src_prepare() {
	kde4-base_src_prepare

	if ! use akonadi; then
		sed -e '/find_package(Akonadi/s/^/# DISABLED /' \
			-e '/macro_log_feature(Akonadi_FOUND/s/TRUE/FALSE/' \
			-e '/add_subdirectory(akonadi)/s/^/# DISABLED /' \
			-e '/add_subdirectory(mailtransport)/s/^/# DISABLED /' \
			-i CMakeLists.txt || die "failed to disable akonadi"
	fi
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build handbook doc)
		$(cmake-utils_use_with ldap)
	)

	kde4-base_src_configure
}
