# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KFMIN=5.64.0
QTMIN=5.12.3
inherit ecm kde.org

DESCRIPTION="Library to expose vcards to KPeople"
HOMEPAGE="https://cgit.kde.org/kpeoplevcard.git"

LICENSE="LGPL-2.1+"
SLOT="5"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-frameworks/kcontacts-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/kpeople-${KFMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
"
RDEPEND="${DEPEND}"
