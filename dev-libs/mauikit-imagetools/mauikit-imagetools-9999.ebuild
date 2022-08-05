# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_QTHELP="true"
KDE_ORG_CATEGORY="maui"
KFMIN=5.82.0
QTMIN=5.15.5
inherit ecm kde.org

DESCRIPTION="MauiKit Image Tools Components"

LICENSE="BSD-2 CC0-1.0 LGPL-2.1+"
SLOT="5"
KEYWORDS=""
IUSE=""

BDEPEND="sys-devel/gettext"
DEPEND="
	>=dev-libs/mauikit-${KFMIN}:5
	>=dev-qt/qtsql-${QTMIN}:5
	>=dev-qt/qtpositioning-${QTMIN}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5
	media-gfx/exiv2:=
	>=media-libs/kquickimageeditor-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
"
RDEPEND="${DEPEND}"
