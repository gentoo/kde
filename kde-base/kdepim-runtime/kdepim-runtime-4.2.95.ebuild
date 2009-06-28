# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim-runtime"
inherit kde4-base

DESCRIPTION="An extensible cross-desktop storage service for PIM data and meta data"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
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
	>=kde-base/kdelibs-${PV}:${SLOT}[kdeprefix=,semantic-desktop?]
	>=kde-base/libkdepim-${PV}:${SLOT}[kdeprefix=]
	x11-misc/shared-mime-info
"
# @since 4.3 - blocks kdemaildir - no longer provided (it's in akonadi now)
RDEPEND="${DEPEND}
	!kdeprefix? (
					!kde-base/kdemaildir[-kdeprefix]
					!kde-base/akonadi[-kdeprefix]	
				)
	kdeprefix? (
					!kde-base/kdemaildir:${SLOT}
					!kde-base/akonadi:${SLOT}
				)
	>=app-office/akonadi-server-1.1.95[mysql]
"

KMEXTRACTONLY="
	korganizer/version.h
"

src_prepare() {
	if ! use semantic-desktop; then
		sed -i -e "s/add_subdirectory( nepomuktag )//"\
			akonadi/resources/CMakeLists.txt\
			|| die "Failed to disable nepomuktag"
	fi

	kde4-base_src_prepare
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

	kde4-base_src_configure
}

src_install() {
	kde4-base_src_install
	# colliding files with nepomuk
	rm -rf "${D}"/${KDEDIR}/share/apps/nepomuk/ontologies/nmo.{desktop,trig}
	rm -rf "${D}"/${KDEDIR}/share/apps/nepomuk/ontologies/nco.{desktop,trig}
}
