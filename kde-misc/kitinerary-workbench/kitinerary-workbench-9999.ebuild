# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="forceoptional"
KDE_ORG_CATEGORY="pim"
PVCUT=$(ver_cut 1-3)
KFMIN=6.0.0
QTMIN=6.6.2
inherit ecm gear.kde.org

DESCRIPTION="Tool for developing extractor scripts for the Itinerary data extraction engine."
HOMEPAGE="https://invent.kde.org/pim/kitinerary-workbench"

LICENSE="LGPL-2+"
SLOT="6"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[widgets]
	>=kde-apps/kitinerary-${PVCUT}:6
	>=kde-apps/kpkpass-${PVCUT}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/ktexteditor-${KFMIN}:6
"
RDEPEND="${DEPEND}"
