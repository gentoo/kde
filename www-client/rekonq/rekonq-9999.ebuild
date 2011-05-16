# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

QT_MINIMAL="4.7"
KDE_MINIMAL="4.6"
KDE_SCM="git"
KDE_LINGUAS_DIR="i18n"
KDE_LINGUAS="ca cs da de el en_GB es et fr hu it ja ko lt nb nds nl pt_BR pt ru sl sr sv uk zh_CN"
KDE_DOC_DIRS="docs"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="A browser based on qt-webkit"
HOMEPAGE="http://rekonq.kde.org/"
[[ ${PV} != *9999* ]] && SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=x11-libs/qt-xmlpatterns-${QT_MINIMAL}
"
RDEPEND="${DEPEND}"

RESTRICT="test"
