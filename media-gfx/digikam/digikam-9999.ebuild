# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MIN_VERSION=3.14.3
KF5MIN=5.60.0
QT5MIN=5.12.3
inherit ecm kde.org toolchain-funcs

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	MY_PV=${PV/_/-}
	MY_P=${PN}-${MY_PV}
	SRC_BRANCH=stable
	[[ ${PV} =~ beta[0-9]$ ]] && SRC_BRANCH=unstable
	SRC_URI="mirror://kde/${SRC_BRANCH}/digikam/${PV}/${MY_P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

DESCRIPTION="Digital photo management application"
HOMEPAGE="https://www.digikam.org/"

LICENSE="GPL-2"
SLOT="5"
IUSE="addressbook calendar dnn +imagemagick gphoto2 +lensfun libav marble mediaplayer mysql opengl openmp +panorama scanner semantic-desktop vkontakte webkit X"

BDEPEND="
	sys-devel/gettext
	panorama? (
		sys-devel/bison
		sys-devel/flex
	)
"
COMMON_DEPEND="
	>=dev-qt/qtconcurrent-${QT5MIN}:5
	>=dev-qt/qtdbus-${QT5MIN}:5
	>=dev-qt/qtgui-${QT5MIN}:5[-gles2]
	>=dev-qt/qtnetwork-${QT5MIN}:5
	>=dev-qt/qtprintsupport-${QT5MIN}:5
	>=dev-qt/qtsql-${QT5MIN}:5[mysql?]
	>=dev-qt/qtwidgets-${QT5MIN}:5
	>=dev-qt/qtxml-${QT5MIN}:5
	>=dev-qt/qtxmlpatterns-${QT5MIN}:5
	dev-libs/expat
	>=kde-frameworks/kconfig-${KF5MIN}:5
	>=kde-frameworks/kconfigwidgets-${KF5MIN}:5
	>=kde-frameworks/kcoreaddons-${KF5MIN}:5
	>=kde-frameworks/ki18n-${KF5MIN}:5
	>=kde-frameworks/kiconthemes-${KF5MIN}:5
	>=kde-frameworks/kio-${KF5MIN}:5
	>=kde-frameworks/knotifications-${KF5MIN}:5
	>=kde-frameworks/knotifyconfig-${KF5MIN}:5
	>=kde-frameworks/kservice-${KF5MIN}:5
	>=kde-frameworks/kwidgetsaddons-${KF5MIN}:5
	>=kde-frameworks/kwindowsystem-${KF5MIN}:5
	>=kde-frameworks/kxmlgui-${KF5MIN}:5
	>=kde-frameworks/solid-${KF5MIN}:5
	>=media-gfx/exiv2-0.26:=
	media-libs/lcms:2
	media-libs/liblqr
	media-libs/libpng:0=
	>=media-libs/opencv-3.1.0:=
	media-libs/tiff:0
	virtual/jpeg:0
	addressbook? (
		>=kde-apps/akonadi-contacts-19.04.3:5
		>=kde-frameworks/kcontacts-${KF5MIN}:5
	)
	calendar? ( >=kde-frameworks/kcalendarcore-${KF5MIN}:5 )
	dnn? ( >=media-libs/opencv-3.1.0:=[contrib,contrib_dnn] )
	gphoto2? ( media-libs/libgphoto2:= )
	imagemagick? ( media-gfx/imagemagick:= )
	lensfun? ( media-libs/lensfun )
	marble? (
		>=dev-qt/qtconcurrent-${QT5MIN}:5
		>=kde-apps/marble-19.04.3:5
		>=kde-frameworks/kbookmarks-${KF5MIN}:5
	)
	mediaplayer? (
		media-libs/qtav[opengl]
		!libav? ( media-video/ffmpeg:= )
		libav? ( media-video/libav:= )
	)
	opengl? (
		>=dev-qt/qtopengl-${QT5MIN}:5
		virtual/opengl
	)
	panorama? ( >=kde-frameworks/threadweaver-${KF5MIN}:5 )
	scanner? ( >=kde-apps/libksane-19.04.3:5 )
	semantic-desktop? ( >=kde-frameworks/kfilemetadata-${KF5MIN}:5 )
	vkontakte? ( net-libs/libkvkontakte:5 )
	!webkit? ( >=dev-qt/qtwebengine-${QT5MIN}:5[widgets] )
	webkit? ( >=dev-qt/qtwebkit-5.212.0_pre20180120:5 )
	X? (
		>=dev-qt/qtx11extras-${QT5MIN}:5
		x11-libs/libX11
	)
"
DEPEND="${COMMON_DEPEND}
	dev-cpp/eigen:3
	dev-libs/boost[threads]
"
RDEPEND="${COMMON_DEPEND}
	mysql? ( virtual/mysql[server] )
	panorama? ( media-gfx/hugin )
"

RESTRICT+=" test"
# bug 366505

pkg_pretend() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
	ecm_pkg_pretend
}

pkg_setup() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
	ecm_pkg_setup
}

# FIXME: Unbundle libraw (libs/rawengine/libraw)
src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=OFF # bug 698192
		-DENABLE_APPSTYLES=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_Jasper=ON
		-DENABLE_AKONADICONTACTSUPPORT=$(usex addressbook)
		$(cmake-utils_use_find_package calendar KF5CalendarCore)
		-DENABLE_FACESENGINE_DNN=$(usex dnn)
		$(cmake-utils_use_find_package gphoto2 Gphoto2)
		$(cmake-utils_use_find_package imagemagick ImageMagick)
		$(cmake-utils_use_find_package lensfun LensFun)
		$(cmake-utils_use_find_package marble Marble)
		-DENABLE_MEDIAPLAYER=$(usex mediaplayer)
		$(cmake-utils_use_find_package mediaplayer QtAV)
		-DENABLE_MYSQLSUPPORT=$(usex mysql)
		-DENABLE_INTERNALMYSQL=$(usex mysql)
		$(cmake-utils_use_find_package opengl OpenGL)
		$(cmake-utils_use_find_package panorama KF5ThreadWeaver)
		$(cmake-utils_use_find_package scanner KF5Sane)
		$(cmake-utils_use_find_package semantic-desktop KF5FileMetaData)
		$(cmake-utils_use_find_package vkontakte KF5Vkontakte)
		-DENABLE_QWEBENGINE=$(usex !webkit)
		$(cmake-utils_use_find_package X X11)
	)

	ecm_src_configure
}
