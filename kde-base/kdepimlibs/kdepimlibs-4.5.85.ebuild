# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KDE_HANDBOOK="optional"
CPPUNIT_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="Common library for KDE PIM apps."
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-2.1"
IUSE="debug ldap semantic-desktop"

# some akonadi tests timeout, that probaly needs more work as its ~700 tests
RESTRICT="test"

DEPEND="
	>=app-crypt/gpgme-1.1.6
	>=dev-libs/boost-1.35.0-r5
	dev-libs/libgpg-error
	>=dev-libs/libical-0.43
	dev-libs/cyrus-sasl
	semantic-desktop? (
		>=app-office/akonadi-server-1.4.52
		$(add_kdebase_dep kdelibs 'semantic-desktop')
		media-sound/phonon
		x11-misc/shared-mime-info
	)
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

	# Disable hardcoded checks
	sed -r -e '/find_package\((Akonadi|SharedDesktopOntologies|Soprano|Nepomuk)/{/macro_optional_/!s/find/macro_optional_&/}' \
		-e '/macro_log_feature\((Akonadi|SHAREDDESKTOPONTOLOGIES|Soprano|Nepomuk)_FOUND/s/ TRUE / FALSE /' \
		-e '/add_subdirectory\((akonadi|mailtransport)/{/macro_optional_/!s/add/macro_optional_&/}' \
		-i CMakeLists.txt || die
	if ! use semantic-desktop; then
		sed -e '/include(SopranoAddOntology)/s/^/#DISABLED /' \
			-i CMakeLists.txt || die
		# More reliable than -DBUILD_akonadi=OFF
		rm -r akonadi mailtransport || die
	fi
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build handbook doc)
		$(cmake-utils_use_with ldap)
		$(cmake-utils_use_with semantic-desktop Akonadi)
		$(cmake-utils_use_with semantic-desktop SharedDesktopOntologies)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
	)

	kde4-base_src_configure
}
