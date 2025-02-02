# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KDE_ORG_CATEGORY=utilities
KFMIN=6.3.0
QTMIN=6.6.2
inherit ecm kde.org

DESCRIPTION="Simple recipe manager taking structured markdown for recipes"
HOMEPAGE="https://invent.kde.org/utilities/kookbook"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
"
RDEPEND="${DEPEND}
	!${CATEGORY}/${PN}:6
	>=dev-qt/qtsvg-${QTMIN}:6
"
