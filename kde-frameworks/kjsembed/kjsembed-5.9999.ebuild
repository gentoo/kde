# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
ECM_QTHELP="false"
ECM_TEST="false"
PVCUT=$(ver_cut 1-2)
QTMIN=5.15.5
inherit ecm frameworks.kde.org

DESCRIPTION="Framework binding JavaScript objects to QObjects"

LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtsvg-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=dev-qt/qtxml-${QTMIN}:5
	=kde-frameworks/ki18n-${PVCUT}*:5
	=kde-frameworks/kjs-${PVCUT}*:5
"
DEPEND="${RDEPEND}
	>=dev-qt/designer-${QTMIN}:5
"
