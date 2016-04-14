# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGIT_BRANCH="frameworks"
KDE_DOXYGEN="true"
KDE_HANDBOOK="true"
KDE_PUNT_BOGUS_DEPS="true"
VIRTUALX_REQUIRED="test"
VIRTUALDBUS_TEST="true"
inherit kde5

DESCRIPTION="Personal finance manager"
HOMEPAGE="https://kmymoney.org"
if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.xz"
fi

LICENSE="GPL-2"
KEYWORDS=""
IUSE="crypt calendar doc ofx quotes"

# TODO: hbci (not yet ported to qt5)
COMMON_DEPEND="
	$(add_frameworks_dep kactivities)
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep khtml)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep sonnet)
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep kcontacts)
	$(add_kdeapps_dep kdiagram)
	$(add_kdeapps_dep kholidays)
	$(add_kdeapps_dep kidentitymanagement)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtsql)
	$(add_qt_dep qtsvg)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	app-office/libalkimia:5
	dev-libs/gmp:0=
	dev-libs/libgpg-error
	x11-misc/shared-mime-info
	calendar? ( dev-libs/libical:= )
	crypt? ( $(add_kdeapps_dep gpgmepp) )
	ofx? ( >=dev-libs/libofx-0.9.4 )
"
DEPEND="${COMMON_DEPEND}
	!app-office/kmymoney:4
	dev-libs/boost
	virtual/pkgconfig
"
RDEPEND="${COMMON_DEPEND}
	quotes? ( dev-perl/Finance-Quote )
"

src_configure() {
	local mycmakeargs=(
		-DUSE_QT_DESIGNER=OFF
		-DENABLE_LIBICAL=$(usex calendar)
		$(cmake-utils_use_find_package crypt KF5Gpgmepp)
		-DUSE_DEVELOPER_DOC=$(usex doc)
		-DENABLE_LIBOFX=$(usex ofx)
	)
	kde5_src_configure
}

src_compile() {
	kde5_src_compile

	use doc && kde5_src_compile apidoc
}

src_install() {
	use doc && HTML_DOCS=("${BUILD_DIR}/apidocs/html/")
	kde5_src_install
}
