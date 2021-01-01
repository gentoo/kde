# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_HANDBOOK="forceoptional"
ECM_TEST="forceoptional"
KFMIN=5.74.0
QTMIN=5.15.1
inherit ecm kde.org

DESCRIPTION="Commandline interface for accessing Akonadi"
HOMEPAGE="https://invent.kde.org/pim/akonadiclient/"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-qt/qtwidgets-${QTMIN}:5
	kde-apps/akonadi:5[xml]
	>=kde-frameworks/kcodecs-${KFMIN}:5
	>=kde-frameworks/kcontacts-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
"
RDEPEND="${DEPEND}"

src_prepare() {
	ecm_src_prepare
	ecm_punt_bogus_dep KF5 KIO	# we don't need it with >=Qt-5.10
}
