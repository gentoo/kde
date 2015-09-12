# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MY_PN=${PN}-kde
KMNAME=${MY_PN}
KDE_TEST="true"
inherit kde5

DESCRIPTION="Adds communication between KDE and your smartphone"
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""

LICENSE="GPL-2+"

DEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifications)
	>=app-crypt/qca-2.1.0:2[qt5,openssl]
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	x11-libs/libfakekey
"
RDEPEND="${DEPEND}
	$(add_plasma_dep plasma-workspace)
	!kde-misc/kdeconnect:4
"

[[ ${KDE_BUILD_TYPE} != live ]] && S=${WORKDIR}/${MY_P}

src_prepare() {
	sed \
		-e 's#${LIBEXEC_INSTALL_DIR}#@KDE_INSTALL_FULL_LIBEXECDIR@#' \
		-i daemon/kdeconnectd.desktop.cmake
	default
}

pkg_postinst(){
	elog
	elog "Optional dependency:"
	elog "sys-fs/sshfs-fuse (for 'remote filesystem browser' plugin)"
	elog
	elog "The Android .apk file is available via"
	elog "https://play.google.com/store/apps/details?id=org.kde.kdeconnect_tp"
	elog
}
