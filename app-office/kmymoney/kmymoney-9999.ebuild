# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

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

# Not yet ported to qt5
# 	hbci? (
# 		>=net-libs/aqbanking-5.3.3
# 		>=sys-libs/gwenhywfar-4.0.1[qt4]
# 	)
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
	$(add_kdeapps_dep kcontacts)
	$(add_kdeapps_dep kdiagram)
	$(add_kdeapps_dep kholidays)
	$(add_kdeapps_dep kidentitymanagement)
	$(add_kdeapps_dep libakonadi)
	app-office/libalkimia:5
	dev-libs/gmp:0
	dev-libs/libgpg-error
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
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
# Not yet ported
# 		$(cmake-utils_use_enable hbci KBANKING)
	local mycmakeargs=(
		-DUSE_QT_DESIGNER=OFF
		$(cmake-utils_use_find_package crypt KF5Gpgmepp)
		$(cmake-utils_use_enable calendar LIBICAL)
		$(cmake-utils_use_use doc DEVELOPER_DOC)
		$(cmake-utils_use_enable ofx LIBOFX)
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
