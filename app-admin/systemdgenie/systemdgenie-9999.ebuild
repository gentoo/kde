# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.3.0
QTMIN=6.6.2
inherit ecm kde.org

if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="mirror://kde/unstable/${PN}/${P}.tar.xz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Systemd managment utility"
HOMEPAGE="https://invent.kde.org/system/systemdgenie"

LICENSE="GPL-2+"
SLOT="0"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	>=kde-frameworks/kauth-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kxmlgui-${KFMIN}:6
	sys-apps/systemd:=
"
RDEPEND="${DEPEND}
	!${CATEGORY}/${PN}:5
"
BDEPEND="sys-devel/gettext"
