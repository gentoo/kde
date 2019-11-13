# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_HANDBOOK="true"
KFMIN=5.60.0
QTMIN=5.12.3
inherit ecm kde.org

DESCRIPTION="Advanced audio player based on KDE frameworks"
HOMEPAGE="https://amarok.kde.org/"

LICENSE="GPL-2"
SLOT="5"
IUSE="ipod lastfm libav mtp ofa podcast wikipedia"

# ipod requires gdk enabled and also gtk compiled in libgpod
BDEPEND="virtual/pkgconfig"
DEPEND="
	app-crypt/qca:2[qt5(+)]
	dev-db/mysql-connector-c:=
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=dev-qt/qtscript-${QTMIN}:5[scripttools]
	>=dev-qt/qtsql-${QTMIN}:5
	>=dev-qt/qtsvg-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=dev-qt/qtxml-${QTMIN}:5
	>=kde-frameworks/attica-${KFMIN}:5
	>=kde-frameworks/karchive-${KFMIN}:5
	>=kde-frameworks/kcmutils-${KFMIN}:5
	>=kde-frameworks/kcodecs-${KFMIN}:5
	>=kde-frameworks/kcompletion-${KFMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kconfigwidgets-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/kcrash-${KFMIN}:5
	>=kde-frameworks/kdbusaddons-${KFMIN}:5
	>=kde-frameworks/kdeclarative-${KFMIN}:5
	>=kde-frameworks/kdnssd-${KFMIN}:5
	>=kde-frameworks/kglobalaccel-${KFMIN}:5
	>=kde-frameworks/kguiaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kiconthemes-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/kitemviews-${KFMIN}:5
	>=kde-frameworks/knewstuff-${KFMIN}:5
	>=kde-frameworks/knotifications-${KFMIN}:5
	>=kde-frameworks/kpackage-${KFMIN}:5
	>=kde-frameworks/kservice-${KFMIN}:5
	>=kde-frameworks/ktexteditor-${KFMIN}:5
	>=kde-frameworks/ktextwidgets-${KFMIN}:5
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:5
	>=kde-frameworks/kwindowsystem-${KFMIN}:5
	>=kde-frameworks/kxmlgui-${KFMIN}:5
	>=kde-frameworks/solid-${KFMIN}:5
	>=kde-frameworks/threadweaver-${KFMIN}:5
	media-libs/phonon[qt5(+)]
	media-libs/taglib
	media-libs/taglib-extras
	sci-libs/fftw:3.0
	sys-libs/zlib
	virtual/opengl
	ipod? (
		dev-libs/glib:2
		media-libs/libgpod[gtk]
	)
	ofa? (
		media-libs/libofa
		!libav? ( media-video/ffmpeg:= )
		libav? ( media-video/libav:= )
	)
	lastfm? ( >=media-libs/liblastfm-1.1.0_pre20150206 )
	mtp? ( media-libs/libmtp )
	podcast? ( >=media-libs/libmygpo-qt-1.0.9_p20180307 )
	wikipedia? ( >=dev-qt/qtwebengine-${QTMIN}:5 )
"
RDEPEND="${DEPEND}
	!media-sound/amarok:4
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	!ofa? ( virtual/ffmpeg )
"

PATCHES=( "${FILESDIR}"/${PN}-2.8.90-mysqld-rpath.patch )

src_configure() {
	local mycmakeargs=(
		-DWITH_MP3Tunes=OFF
		-DWITH_PLAYER=ON
		-DWITH_UTILITIES=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_Googlemock=ON
		-DWITH_MYSQL_EMBEDDED=OFF
		-DWITH_IPOD=$(usex ipod)
		$(cmake-utils_use_find_package lastfm LibLastFm)
		$(cmake-utils_use_find_package mtp Mtp)
		$(cmake-utils_use_find_package ofa LibOFA)
		$(cmake-utils_use_find_package podcast Mygpo-qt5)
		$(cmake-utils_use_find_package wikipedia Qt5WebEngine)
	)

	use ipod && mycmakeargs+=( DWITH_GDKPixBuf=ON )

	ecm_src_configure
}

pkg_postinst() {
	ecm_pkg_postinst

	pkg_is_installed() {
		echo "${1} ($(has_version ${1} || echo "not ")installed)"
	}

	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		elog "You'll have to configure amarok to use an external db server, one of:"
		elog "    $(pkg_is_installed dev-db/mariadb)"
		elog "    $(pkg_is_installed dev-db/mysql)"
		elog "Please read https://community.kde.org/Amarok/Community/MySQL for details on how"
		elog "to configure the external db and migrate your data from the embedded database."
	fi
}
