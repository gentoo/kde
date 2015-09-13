# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_BRANCH="kf5"
KDE_HANDBOOK="true"
KDE_TEST="true"
VIRTUALX_REQUIRED="test"
VIRTUALDBUS_TEST="true"
inherit flag-o-matic kde5 pax-utils

DESCRIPTION="Advanced audio player based on KDE framework"
HOMEPAGE="https://amarok.kde.org/"

LICENSE="GPL-2"
IUSE="+embedded ffmpeg ipod lastfm mtp ofa opengl +utils"

if [[ ${KDE_BUILD_TYPE} == live ]]; then
	RESTRICT="test"
fi

# ipod requires gdk enabled and also gtk compiled in libgpod
COMMONDEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kdnssd)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep plasma)
	$(add_frameworks_dep solid)
	$(add_frameworks_dep threadweaver)
	app-crypt/qca:2[qt5]
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtscript:5[scripttools]
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	media-libs/phonon[qt5]
	>=media-libs/taglib-1.7[asf,mp4]
	>=media-libs/taglib-extras-1.0.1
	sys-libs/zlib
	>=virtual/mysql-5.1[embedded?]
	ffmpeg? (
		virtual/ffmpeg
		ofa? ( >=media-libs/libofa-0.9.0 )
	)
	ipod? (
		dev-libs/glib:2
		>=media-libs/libgpod-0.7.0[gtk]
	)
	lastfm? ( media-libs/liblastfm[qt5] )
	mtp? ( >=media-libs/libmtp-1.0.0 )
	opengl? ( virtual/opengl )
"
# 	cdda? (
# 		$(add_kdeapps_dep libkcddb)
# 		$(add_kdeapps_dep libkcompactdisc)
# 		$(add_kdeapps_dep audiocd-kio)
# 	)
DEPEND="${COMMONDEPEND}
	virtual/pkgconfig
	test? ( dev-cpp/gmock )
"
RDEPEND="${COMMONDEPEND}"

src_configure() {
	# Append minimal-toc cflag for ppc64, see bug 280552 and 292707
# 	use ppc64 && append-flags -mminimal-toc

	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_QJSON=ON
		-DWITH_MP3Tunes=OFF
		-DWITH_PLAYER=ON
		-DWITH_SPECTRUM_ANALYZER=OFF
		$(cmake-utils_use embedded WITH_MYSQL_EMBEDDED)
		$(cmake-utils_use_find_package ffmpeg FFmpeg)
		$(cmake-utils_use_with ipod)
		$(cmake-utils_use_find_package ipod GDKPixBuf)
		$(cmake-utils_use_find_package lastfm LibLastFm)
		$(cmake-utils_use_find_package mtp)
		$(cmake-utils_use_find_package ofa LibOFA)
		$(cmake-utils_use utils WITH_UTILITIES)
	)

	kde5_src_configure
}

src_install() {
	kde5_src_install

	# bug 481592
	pax-mark m "${ED}"/usr/bin/amarok
}

pkg_postinst() {
	kde5_pkg_postinst

	if ! use embedded; then
		echo
		elog "You've disabled the amarok support for embedded mysql DBs."
		elog "You'll have to configure amarok to use an external db server."
		echo
		elog "Please read http://amarok.kde.org/wiki/MySQL_Server for details on how"
		elog "to configure the external db and migrate your data from the embedded database."
		echo

		if has_version "virtual/mysql[minimal]"; then
			elog "You built mysql with the minimal use flag, so it doesn't include the server."
			elog "You won't be able to use the local mysql installation to store your amarok collection."
			echo
		fi
	fi
}
