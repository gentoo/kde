# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_HANDBOOK="forceoptional"
KFMIN=5.80.0
QTMIN=5.15.2
inherit ecm kde.org optfeature

DESCRIPTION="Advanced audio player based on KDE frameworks"
HOMEPAGE="https://amarok.kde.org/"

LICENSE="GPL-2"
SLOT="5"
IUSE="ipod lastfm mariadb mtp ofa podcast wikipedia"

# USE="ipod" requires gdk enabled and also gtk compiled in libgpod.
BDEPEND="virtual/pkgconfig"
DEPEND="
	>=app-crypt/qca-2.3.0:2
	>=dev-qt/designer-${QTMIN}:5
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
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
	>=media-libs/phonon-4.11.0
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
		media-video/ffmpeg:=
	)
	lastfm? ( >=media-libs/liblastfm-1.1.0_pre20150206 )
	mariadb? ( dev-db/mariadb-connector-c:= )
	!mariadb? ( dev-db/mysql-connector-c:= )
	mtp? ( media-libs/libmtp )
	podcast? ( >=media-libs/libmygpo-qt-1.0.9_p20180307 )
	wikipedia? ( >=dev-qt/qtwebengine-${QTMIN}:5 )
"
RDEPEND="${DEPEND}
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=kde-frameworks/kirigami-${KFMIN}:5
	!ofa? ( media-video/ffmpeg )
"

src_configure() {
	local mycmakeargs=(
		-DWITH_MP3Tunes=OFF
		-DWITH_PLAYER=ON
		-DWITH_UTILITIES=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_Googlemock=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_MySQLe=ON
		-DWITH_IPOD=$(usex ipod)
		$(cmake_use_find_package lastfm LibLastFm)
		$(cmake_use_find_package !mariadb MySQL)
		$(cmake_use_find_package mtp Mtp)
		$(cmake_use_find_package ofa LibOFA)
		$(cmake_use_find_package podcast Mygpo-qt5)
		$(cmake_use_find_package wikipedia Qt5WebEngine)
	)
	use ipod && mycmakeargs+=( DWITH_GDKPixBuf=ON )

	ecm_src_configure
}

pkg_postinst() {
	ecm_pkg_postinst

	pkg_is_installed() {
		echo "${1} ($(has_version ${1} || echo "not ")installed)"
	}

	optfeature "Audio CD support" kde-apps/audiocd-kio

	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		elog "You'll have to configure amarok to use an external database server:"
		if use mariadb ; then
			elog "    $(pkg_is_installed dev-db/mariadb)"
			elog "    For preliminary configuration of MariaDB Server please refer to"
			elog "    https://wiki.gentoo.org/wiki/MariaDB#Configuration"
		else
			elog "    $(pkg_is_installed dev-db/mysql)"
			elog "    For preliminary configuration of MySQL Server please refer to"
			elog "    https://wiki.gentoo.org/wiki/MySQL#Configuration"
		fi
		elog "Please read https://community.kde.org/Amarok/Community/MySQL for details on how"
		elog "to configure the external database and migrate your data from the embedded database."
		elog "To create external amarok database with default user/password please:"
		elog "    1. Make sure that MySQL or MariaDB is installed and configured (see above)"
		elog "    2. Ensure that 'mysql' service is started and then run command 'emerge --config amarok'"
		elog "    3. On 'Configure Amarok - Database' menu page check 'Use external MySQL database' and press OK"
	fi
}

pkg_config() {
	# Create external mysql database with amarok default user/password
	local AMAROK_DB_NAME="amarokdb"
	local AMAROK_DB_USER_NAME="amarokuser"
	local AMAROK_DB_USER_PWD="password"

	einfo "Initializing ${PN} MySQL database 'amarokdb':"
	ewarn "If prompted for a password, please enter your MySQL root password."
	ewarn ""

	if [[ -e "${EROOT}"/usr/bin/mysql ]]; then
		"${EROOT}"/usr/bin/mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS ${AMAROK_DB_NAME}; GRANT ALL PRIVILEGES ON ${AMAROK_DB_NAME}.* TO '${AMAROK_DB_USER_NAME}' IDENTIFIED BY '${AMAROK_DB_USER_PWD}'; FLUSH PRIVILEGES;"
	fi
	einfo "${PN} MySQL database 'amarokdb' successfully initialized!"
}
