# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_HANDBOOK="forceoptional"
ECM_TEST="forceoptional"
KF5MIN=5.60.0
QT5MIN=5.12.3
inherit ecm kde.org

DESCRIPTION="Project management application"
HOMEPAGE="https://www.calligra.org/"

if [[ ${KDE_BUILD_TYPE} == release ]]; then
	SRC_URI="mirror://kde/unstable/calligra/${PN}-${PV}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="5"
IUSE="activities +holidays kwallet X"

# FIXME: Disabled by upstream for good reason
# Crashes (https://bugs.kde.org/show_bug.cgi?id=311940)
# $(add_kdeapps_dep akonadi)
# $(add_kdeapps_dep akonadi-contacts)
# Currently upstream-disabled:
# =dev-libs/kproperty-3.0*:5
# =dev-libs/kreport-3.0*:5
DEPEND="
	>=dev-qt/designer-${QT5MIN}:5
	>=dev-qt/qtdbus-${QT5MIN}:5
	>=dev-qt/qtgui-${QT5MIN}:5
	>=dev-qt/qtprintsupport-${QT5MIN}:5
	>=dev-qt/qtwidgets-${QT5MIN}:5
	>=dev-qt/qtxml-${QT5MIN}:5
	>=kde-frameworks/karchive-${KF5MIN}:5
	>=kde-frameworks/kconfig-${KF5MIN}:5
	>=kde-frameworks/kconfigwidgets-${KF5MIN}:5
	>=kde-frameworks/kcoreaddons-${KF5MIN}:5
	>=kde-frameworks/kdbusaddons-${KF5MIN}:5
	>=kde-frameworks/kglobalaccel-${KF5MIN}:5
	>=kde-frameworks/kguiaddons-${KF5MIN}:5
	>=kde-frameworks/khtml-${KF5MIN}:5
	>=kde-frameworks/ki18n-${KF5MIN}:5
	>=kde-frameworks/kiconthemes-${KF5MIN}:5
	>=kde-frameworks/kio-${KF5MIN}:5
	>=kde-frameworks/kitemviews-${KF5MIN}:5
	>=kde-frameworks/kjobwidgets-${KF5MIN}:5
	>=kde-frameworks/knotifications-${KF5MIN}:5
	>=kde-frameworks/kparts-${KF5MIN}:5
	>=kde-frameworks/kservice-${KF5MIN}:5
	>=kde-frameworks/ktextwidgets-${KF5MIN}:5
	>=kde-frameworks/kwidgetsaddons-${KF5MIN}:5
	>=kde-frameworks/kwindowsystem-${KF5MIN}:5
	>=kde-frameworks/kxmlgui-${KF5MIN}:5
	dev-lang/perl
	dev-libs/kdiagram:5
	sys-libs/zlib
	activities? ( >=kde-frameworks/kactivities-${KF5MIN}:5 )
	holidays? ( >=kde-frameworks/kholidays-${KF5MIN}:5 )
	kwallet? (
		app-crypt/qca:2[qt5(+)]
		>=kde-frameworks/kwallet-${KF5MIN}:5
	)
	X? (
		>=dev-qt/qtx11extras-${QT5MIN}:5
		x11-libs/libX11
	)
"
RDEPEND="${DEPEND}
	!app-office/calligra[calligra_features_plan(-)]
	>=dev-qt/qtsvg-${QT5MIN}:5
"

RESTRICT+=" test"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package activities KF5Activities)
		$(cmake-utils_use_find_package holidays KF5Holidays)
		$(cmake-utils_use_find_package kwallet Qca-qt5)
		$(cmake-utils_use_find_package kwallet KF5Wallet)
	)
	# Qt5DBus can't be disabled because of KF5DBusAddons dependency

	kde5_src_configure
}
