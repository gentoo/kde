# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeplasma-addons/kdeplasma-addons-4.14.3.ebuild,v 1.4 2015/02/14 14:35:09 ago Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="Extra Plasma applets and engines"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="attica debug desktopglobe exif fcitx ibus json +kdepim nepomuk oauth
qalculate qwt scim"

RESTRICT=test
# tests hang

# krunner is only needed to generate dbus interface for lancelot
COMMON_DEPEND="
	app-crypt/qca:2[qt4(+)]
	$(add_kdebase_dep kdelibs 'nepomuk?')
	$(add_kdebase_dep krunner '' 4.11)
	$(add_kdebase_dep plasma-workspace 'nepomuk?' 4.11)
	x11-misc/shared-mime-info
	attica? ( dev-libs/libattica )
	desktopglobe? ( $(add_kdebase_dep marble) )
	exif? ( $(add_kdebase_dep libkexiv2) )
	fcitx? ( app-i18n/fcitx[dbus(+)] )
	ibus? ( app-i18n/ibus )
	json? ( dev-libs/qjson )
	kdepim? ( $(add_kdebase_dep kdepimlibs) )
	oauth? ( dev-libs/qoauth )
	qalculate? ( sci-libs/libqalculate )
	qwt? ( x11-libs/qwt:5 )
	scim? ( app-i18n/scim )
"
DEPEND="${COMMON_DEPEND}
	dev-cpp/eigen:2
"
RDEPEND="${COMMON_DEPEND}
	|| ( app-crypt/qca-ossl:2 app-crypt/qca:2[openssl] )
"

src_configure() {
	local mycmakeargs=(
		-DDBUS_INTERFACES_INSTALL_DIR="${EPREFIX}/usr/share/dbus-1/interfaces/"
		$(cmake-utils_use_with attica LibAttica)
		$(cmake-utils_use_with desktopglobe Marble)
		$(cmake-utils_use_with exif Kexiv2)
		$(cmake-utils_use_build ibus)
		$(cmake-utils_use_with json QJSON)
		$(cmake-utils_use_with kdepim KdepimLibs)
		$(cmake-utils_use_with nepomuk)
		$(cmake-utils_use_with oauth QtOAuth)
		$(cmake-utils_use_with qalculate)
		$(cmake-utils_use_with qwt)
		$(cmake-utils_use_build scim)
	)

	kde4-base_src_configure
}
