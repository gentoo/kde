# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdepim
inherit kde4svn-meta eutils

DESCRIPTION="An extensible cross-desktop storage service for PIM data and meta data"
KEYWORDS=""
# add when libmapi becomes available with an ebuild
#exchange
IUSE="debug nepomuk plasma"

# add when libmapi becomes available with an ebuild
#exchange? ( net-libs/libmapi )
RDEPEND="app-misc/strigi
	app-office/akonadi-server
	dev-libs/boost
	dev-libs/libxslt
	>=kde-base/kdemaildir-${PV}:${SLOT}
	>=kde-base/libkdepim-${PV}:${SLOT}
	>=x11-misc/shared-mime-info-0.20
	nepomuk? ( >=kde-base/nepomuk-${PV}:${SLOT} )
	plasma? ( kde-base/libplasma:${SLOT} )"
DEPEND="${RDEPEND}
	dev-libs/libxml2"

KMEXTRACTONLY="libkdepim/
	maildir/"

pkg_setup() {
	if ! built_with_use app-misc/strigi qt4; then
		eerror""
		eerror"you have to compile app-misc/strigi with qt4 support"
		eerror""
		die "app-misc/strigi needs to be compiled with qt4 support"
	fi
	kde4overlay-meta_pkg_setup
}
src_compile() {
	# Set the dbus dirs, otherwise it searches in KDEDIR
	mycmakeargs="${mycmakeargs}
		-DAKONADI_DBUS_INTERFACES_INSTALL_DIR=/usr/share/dbus-1/interfaces
		-DAKONADI_DBUS_SERVICES_INSTALL_DIR=/usr/share/dbus-1/services"
	# replace with $(cmake-utils_use_with exchange OpenChange) when libmapi becomes available with an ebuild
	mycmakeargs="${mycmakeargs}
		-DWITH_LibXslt=ON
		-DWITH_OpenChange=OFF
		$(cmake-utils_use_with nepomuk Nepomuk)
		$(cmake-utils_use_with plasma Plasma)"

	kde4overlay-meta_src_compile
}

src_test() {
	# disable broken test
	sed -i -e '/mailserializerplugintest/ s/^/#DO_NOT_RUN_TEST /' \
		"${S}"/akonadi/plugins/tests/CMakeLists.txt || \
		die "sed to disable mailserializerplugintest failed."

	kde4overlay-meta_src_test
}
