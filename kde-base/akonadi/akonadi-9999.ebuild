# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

if [[ ${PV} = *9999* ]]; then
	KMNAME="kdepim"
else
	KMNAME="kdepim-runtime"
	KMNOMODULE="true"
fi
inherit kde4-meta

DESCRIPTION="An extensible cross-desktop storage service for PIM data and meta data"
KEYWORDS=""
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
		!<kde-base/kdepim-kresources-4.2.95[-kdeprefix]
	)
	kdeprefix? (
		!kde-base/kdemaildir:${SLOT}
		!<kde-base/kdepim-kresources-4.2.95:${SLOT}[kdeprefix]
	)
	>=app-office/akonadi-server-1.1.95[mysql]
"

src_prepare() {
	local pref="${S}"
	[[ ${KMNAME} != "kdepim-runtime" ]] && pref="${S}/${PN}"
	if ! use semantic-desktop; then
		sed -i -e "s/add_subdirectory( nepomuktag )//"\
			"${pref}"/resources/CMakeLists.txt\
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

src_install() {
	kde4-meta_src_install
	# colliding files with nepomuk
	rm -rf "${D}"/${KDEDIR}/share/apps/nepomuk/ontologies/nmo.{desktop,trig}
	rm -rf "${D}"/${KDEDIR}/share/apps/nepomuk/ontologies/nco.{desktop,trig}
}
