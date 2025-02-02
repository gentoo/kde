# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional"
ECM_TEST="true"
KFMIN=6.5.0
QTMIN=6.7.2
inherit ecm kde.org

DESCRIPTION="Commandline interface for accessing Akonadi"
HOMEPAGE="https://invent.kde.org/pim/akonadiclient/"

LICENSE="GPL-2"
SLOT="6"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[widgets]
	kde-apps/akonadi:6[xml]
	kde-apps/akonadi-contacts:6
	kde-apps/kmime:6
	>=kde-frameworks/kcodecs-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcontacts-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	sys-libs/ncurses:=
"
RDEPEND="${DEPEND}
	!${CATEGORY}/${PN}:5
"
