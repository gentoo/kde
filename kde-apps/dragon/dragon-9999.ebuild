# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional"
KFMIN=6.16.0
QTMIN=6.9.1
inherit ecm gear.kde.org xdg

DESCRIPTION="Simple video player"
HOMEPAGE="https://apps.kde.org/dragonplayer/"

LICENSE="GPL-2+ || ( GPL-2 GPL-3 ) handbook? ( FDL-1.2 )"
SLOT="6"
KEYWORDS=""
IUSE=""

# Upstream only supports the ffmpeg backend https://bugs.kde.org/show_bug.cgi?id=506940
# slot op: Uses Qt6MultimediaPrivate for Qt6::QFFmpegMediaPlugin
DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtmultimedia-${QTMIN}:6=[ffmpeg]
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/kservice-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	media-video/ffmpeg:=
"
RDEPEND="${DEPEND}"
BDEPEND="sys-devel/gettext"
