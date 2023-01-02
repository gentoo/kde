# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional"
inherit ecm kde.org

DESCRIPTION="Graphviz dot graph file viewer"
HOMEPAGE="https://apps.kde.org/kgraphviewer/"

if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="mirror://kde/stable/${PN}/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="GPL-2 GPL-2+ LGPL-2+ LGPL-2.1+ handbook? ( FDL-1.2 )"
SLOT="5"
IUSE=""

RDEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	kde-frameworks/kconfig:5
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/ki18n:5
	kde-frameworks/kparts:5
	kde-frameworks/kwidgetsaddons:5
	kde-frameworks/kxmlgui:5
	>=media-gfx/graphviz-2.30
"
DEPEND="${RDEPEND}
	dev-libs/boost
"
