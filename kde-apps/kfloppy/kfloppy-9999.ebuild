# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional"
KFMIN=6.0.0
QTMIN=6.6.2
inherit ecm kde.org

DESCRIPTION="Straightforward graphical means to format 3.5\" and 5.25\" floppy disks"
HOMEPAGE="https://apps.kde.org/kfloppy/"

LICENSE="GPL-2" # TODO: CHECK
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-qt/qt5compat-${QTMIN}:6
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	>=kde-frameworks/kcompletion-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kxmlgui-${KFMIN}:6
"
RDEPEND="${DEPEND}
	!${CATEGORY}/${PN}:5
"
