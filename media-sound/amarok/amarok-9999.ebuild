# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_HANDBOOK="true"
KDE_TEST="true"
VIRTUALX_REQUIRED="test"
VIRTUALDBUS_TEST="true"
inherit flag-o-matic kde5 pax-utils

DESCRIPTION="Advanced audio player based on KDE frameworks"
HOMEPAGE="https://amarok.kde.org/"

LICENSE="GPL-2"
IUSE="+embedded ffmpeg ipod lastfm mtp ofa podcast wikipedia"

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
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep kdnssd)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kpackage)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep solid)
	$(add_frameworks_dep threadweaver)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtscript 'scripttools')
	$(add_qt_dep qtsql)
	$(add_qt_dep qtsvg)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	app-crypt/qca:2[qt5(+)]
	media-libs/phonon[qt5(+)]
	>=media-libs/taglib-1.7[asf(+),mp4(+)]
	>=media-libs/taglib-extras-1.0.1
	sci-libs/fftw:3.0
	sys-libs/zlib
	>=virtual/mysql-5.1[embedded?]
	virtual/opengl
	ffmpeg? (
		virtual/ffmpeg
		ofa? ( >=media-libs/libofa-0.9.0 )
	)
	ipod? (
		dev-libs/glib:2
		>=media-libs/libgpod-0.7.0[gtk]
	)
	lastfm? ( >=media-libs/liblastfm-1.1.0_pre20150206 )
	mtp? ( >=media-libs/libmtp-1.0.0 )
	podcast? ( >=media-libs/libmygpo-qt-1.0.9[qt5(+)] )
	wikipedia? ( $(add_qt_dep qtwebengine) )
"
DEPEND="${COMMONDEPEND}
	virtual/pkgconfig
	test? ( dev-cpp/gmock )
"
RDEPEND="${COMMONDEPEND}
	!media-sound/amarok:4
	$(add_qt_dep qtquickcontrols2)
"

PATCHES=( "${FILESDIR}"/${PN}-2.8.90-mysqld-rpath.patch )

src_configure() {
	local mycmakeargs=(
		-DWITH_MP3Tunes=OFF
		-DWITH_PLAYER=ON
		-DWITH_UTILITIES=ON
		-DWITH_MYSQL_EMBEDDED=$(usex embedded)
		$(cmake-utils_use_find_package ffmpeg FFmpeg)
		-DWITH_IPOD=$(usex ipod)
		$(cmake-utils_use_find_package lastfm LibLastFm)
		$(cmake-utils_use_find_package mtp Mtp)
		$(cmake-utils_use_find_package ofa LibOFA)
		$(cmake-utils_use_find_package podcast Mygpo-qt5)
		$(cmake-utils_use_find_package wikipedia Qt5WebEngine)
	)

	use ipod && mycmakeargs+=( DWITH_GDKPixBuf=ON )

	# bug 581554: add libmysqld location for rpath patch
	use embedded && mycmakeargs+=( -DMYSQLD_DIR="${EPREFIX}/usr/$(get_libdir)/mysql" )

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
		elog "You've disabled the amarok support for embedded mysql DBs."
		elog "You'll have to configure amarok to use an external db server."
		elog "Please read https://community.kde.org/Amarok/Community/MySQL for details on how"
		elog "to configure the external db and migrate your data from the embedded database."

		if has_version "virtual/mysql[minimal]"; then
			elog
			elog "You built mysql with the minimal use flag, so it doesn't include the server."
			elog "You won't be able to use the local mysql installation to store your amarok collection."
		fi
	fi
}
