# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Extra Plasma applets and engines."
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"

KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="attica debug desktopglobe exif qalculate qwt scim semantic-desktop"

# krunner is only needed to generate dbus interface for lancelot
COMMON_DEPEND="
	app-crypt/qca:2
	app-crypt/qca-ossl:2
	$(add_kdebase_dep kdelibs 'semantic-desktop=')
	$(add_kdebase_dep krunner)
	$(add_kdebase_dep plasma-workspace 'semantic-desktop=')
	x11-misc/shared-mime-info
	attica? ( dev-libs/libattica )
	desktopglobe? ( $(add_kdebase_dep marble) )
	exif? ( $(add_kdebase_dep libkexiv2) )
	qalculate? ( sci-libs/libqalculate )
	qwt? ( x11-libs/qwt:5 )
	scim? ( app-i18n/scim )
	semantic-desktop? (
		$(add_kdebase_dep kdepimlibs 'semantic-desktop')
		$(add_kdebase_dep plasma-workspace 'rss')
	)
"
DEPEND="${COMMON_DEPEND}
	dev-cpp/eigen:2
"
RDEPEND="${COMMON_DEPEND}
"

PATCHES=(
	"${FILESDIR}/${PN}-4.7.3-knowledge.patch"
	"${FILESDIR}/${PN}-4.7.80-fix-build-lancelot.patch"
	"${FILESDIR}/${PN}-4.7.80-remove-outdated-statements.patch"
	"${FILESDIR}/${PN}-4.7.80-fix-build-marble-wallpaper.patch"
)

src_prepare() {
	use semantic-desktop || epatch "${FILESDIR}/${PN}-4.6.2-optional-akonadi.patch"
	kde4-base_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DDBUS_INTERFACES_INSTALL_DIR="${EPREFIX}/usr/share/dbus-1/interfaces/"
		$(cmake-utils_use_with attica LibAttica)
		$(cmake-utils_use_with desktopglobe Marble)
		$(cmake-utils_use_with exif Kexiv2)
		$(cmake-utils_use_with qalculate)
		$(cmake-utils_use_with qwt)
		$(cmake-utils_use_with semantic-desktop KdepimLibs)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with scim)
	)

	kde4-base_src_configure
}
