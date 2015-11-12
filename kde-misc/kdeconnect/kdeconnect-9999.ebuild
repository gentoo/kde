# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MY_PN=${PN}-kde
KMNAME=${MY_PN}
KDE_HANDBOOK="true"
KDE_TEST="true"
inherit kde5

DESCRIPTION="Adds communication between KDE and your smartphone"
HOMEPAGE="https://kde.org/ https://community.kde.org/KDEConnect"

KEYWORDS=""
LICENSE="GPL-2+"
IUSE="app +telepathy wayland"

COMMON_DEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kservice)
	>=app-crypt/qca-2.1.0:2[qt5,openssl]
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	x11-libs/libfakekey
	x11-libs/libX11
	x11-libs/libXtst
	telepathy? ( net-libs/telepathy-qt[qt5] )
	wayland? ( $(add_plasma_dep kwayland) )
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!kde-misc/kdeconnect:4
	$(add_plasma_dep plasma-workspace)
	wayland? ( $(add_plasma_dep kwin) )
"

[[ ${KDE_BUILD_TYPE} != live ]] && S=${WORKDIR}/${MY_P}

src_prepare() {
	sed \
		-e 's#${LIBEXEC_INSTALL_DIR}#@KDE_INSTALL_FULL_LIBEXECDIR@#' \
		-i daemon/kdeconnectd.desktop.cmake

	kde5_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DEXPERIMENTALAPP_ENABLED=$(usex app)
		$(cmake-utils_use_find_package handbook KF5DocTools)
		$(cmake-utils_use_find_package telepathy TelepathyQt5)
		$(cmake-utils_use_find_package telepathy TelepathyQt5Service)
		$(cmake-utils_use_find_package wayland KF5Wayland)
	)

	kde5_src_configure
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
