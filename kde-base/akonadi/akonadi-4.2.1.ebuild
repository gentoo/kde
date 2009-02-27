# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/akonadi/akonadi-4.2.0.ebuild,v 1.2 2009/02/01 06:20:27 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="An extensible cross-desktop storage service for PIM data and meta data"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
# add when libmapi becomes available with an ebuild
#exchange
IUSE="debug +semantic-desktop"

# add when libmapi becomes available with an ebuild
#exchange? ( net-libs/libmapi )
# not sure about libxml2... - reavertm
DEPEND="
	dev-libs/boost
	dev-libs/libxml2
	dev-libs/libxslt
	>=kde-base/kdemaildir-${PV}:${SLOT}
	>=kde-base/libkdepim-${PV}:${SLOT}
	x11-misc/shared-mime-info
	>=kde-base/kdelibs-${PV}:${SLOT}[semantic-desktop?]
"

RDEPEND="${DEPEND}
	>=app-office/akonadi-server-1.1[mysql]
"

KMEXTRACTONLY="
	libkdepim/
	maildir/
"

src_prepare() {
	if ! use semantic-desktop; then
		sed -i -e "s/add_subdirectory( nepomuktag )//"\
			akonadi/resources/CMakeLists.txt\
			|| die "Failed to disable nepomuktag"
	fi

	kde4-meta_src_prepare
}

src_configure() {
	# Set the dbus dirs, otherwise it searches in KDEDIR
	mycmakeargs="${mycmakeargs}
		-DAKONADI_DBUS_INTERFACES_INSTALL_DIR=/usr/share/dbus-1/interfaces
		-DAKONADI_DBUS_SERVICES_INSTALL_DIR=/usr/share/dbus-1/services"
	# replace with $(cmake-utils_use_with exchange OpenChange) when libmapi becomes available with an ebuild
	mycmakeargs="${mycmakeargs}
		-DWITH_LibXslt=ON
		-DWITH_OpenChange=OFF
		-DWITH_GNOKII=OFF
		-DWITH_GLIB2=OFF
		-DWITH_OpenSync=OFF
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)"

	kde4-meta_src_configure
}

src_test() {
	# disable broken test
	sed -i -e '/mailserializerplugintest/ s/^/#DO_NOT_RUN_TEST /' \
		"${S}"/akonadi/plugins/tests/CMakeLists.txt || \
		die "sed to disable mailserializerplugintest failed."

	kde4-meta_src_test
}
