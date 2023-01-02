# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional"
inherit ecm kde.org

DESCRIPTION="GUI for creating and editing regular expressions"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS=""
IUSE=""

BDEPEND="
	sys-devel/bison
	sys-devel/flex
"
DEPEND="
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	kde-frameworks/kconfig:5
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/kcrash:5
	kde-frameworks/ki18n:5
	kde-frameworks/kiconthemes:5
	kde-frameworks/kservice:5
	kde-frameworks/ktextwidgets:5
	kde-frameworks/kwidgetsaddons:5
"
RDEPEND="${DEPEND}"
