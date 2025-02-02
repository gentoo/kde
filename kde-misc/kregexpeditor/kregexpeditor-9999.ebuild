# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional"
KFMIN=6.3.0
inherit ecm kde.org

DESCRIPTION="GUI for creating and editing regular expressions"

LICENSE="GPL-2"
SLOT="6"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtbase:6[gui,widgets,xml]
	kde-frameworks/kconfig:6
	kde-frameworks/kconfigwidgets:6
	kde-frameworks/kcoreaddons:6
	kde-frameworks/kcrash:6
	kde-frameworks/ki18n:6
	kde-frameworks/ktextwidgets:6
	kde-frameworks/kwidgetsaddons:6
"
RDEPEND="${DEPEND}"
BDEPEND="
	sys-devel/bison
	sys-devel/flex
"
