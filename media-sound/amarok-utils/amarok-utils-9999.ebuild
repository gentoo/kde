# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/multimedia"
KMMODULE="amarok"
KDE_REQUIRED="never"
inherit kde4-base

DESCRIPTION="Variuos utility programs for Amarok."
HOMEPAGE="http://amarok.kde.org/"
ESVN_PROJECT="${KMMODULE}"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	>=media-libs/taglib-1.5
	>=media-libs/taglib-extras-0.1
	>=x11-libs/qt-core-4.4:4
	>=x11-libs/qt-dbus-4.4:4
"
RDEPEND="${DEPEND}
	!<media-sound/amarok-2.0.90:${SLOT}
"

pkg_setup() {
	kde4-base_pkg_setup

	if [[ -d "${ESVN_STORE_DIR}/${PN}" ]]; then
		echo
		elog "${P} now is fetched to the same location as media-sound/amarok-9999"
		ewarn "Removing old SVN storage location ${ESVN_STORE_DIR}/${PN}."
		echo
		rm -fr "${ESVN_STORE_DIR}/${PN}" || \
			eerror "Failed to remove old storage directory at ${ESVN_STORE_DIR}/${PN}"
	fi
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_PLAYER=OFF
		-DWITH_UTILITIES=ON"

	kde4-base_src_configure
}
