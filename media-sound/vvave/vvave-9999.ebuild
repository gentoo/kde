# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KDE_ORG_CATEGORY="maui"
KFMIN=5.82.0
QTMIN=5.15.5
inherit ecm kde.org

DESCRIPTION="Tiny Qt music player by KDE"
HOMEPAGE="https://vvave.kde.org/"

LICENSE="GPL-3+"
SLOT="5"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-libs/mauikit
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtmultimedia-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=dev-qt/qtsql-${QTMIN}:5
	>=dev-qt/qtsvg-${QTMIN}:5
	>=dev-qt/qtwebengine-${QTMIN}:5
	>=dev-qt/qtwebsockets-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=dev-qt/qtxml-${QTMIN}:5
	>=kde-frameworks/attica-${KFMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/knotifications-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	media-libs/taglib
"
RDEPEND="${DEPEND}
	>=kde-frameworks/kirigami-${KFMIN}:5
	>=dev-qt/qtgraphicaleffects-${QTMIN}:5
	media-plugins/gst-plugins-meta:1.0[ffmpeg,mp3]
"
