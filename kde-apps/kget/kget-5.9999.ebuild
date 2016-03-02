# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK="true"
EGIT_BRANCH="kf5_port"
inherit kde5

DESCRIPTION="An advanced download manager for KDE"
HOMEPAGE="https://www.kde.org/applications/internet/kget/"
KEYWORDS=""
IUSE="gpg mms sqlite"

# TODO: not yet ported
# 	bittorrent? ( 
# 		app-crypt/qca:2
# 		net-libs/libktorrent
# 	)
RDEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep solid)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtsql)
	$(add_qt_dep qttest)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	gpg? ( $(add_kdeapps_dep gpgmepp) )
	mms? ( media-libs/libmms )
	sqlite? ( dev-db/sqlite:3 )
"

DEPEND="${RDEPEND}
	dev-libs/boost
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with gpg QGpgme)
		$(cmake-utils_use_with mms LibMms)
		$(cmake-utils_use_with sqlite)
	)
	kde5_src_configure
}
