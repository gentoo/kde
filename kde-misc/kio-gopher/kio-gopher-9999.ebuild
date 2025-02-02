# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KDE_ORG_CATEGORY="network"
ECM_HANDBOOK="forceoptional"
KFMIN=6.5.0
QTMIN=6.7.2
inherit ecm kde.org

DESCRIPTION="Gopher KIO worker for Konqueror"
HOMEPAGE="https://userbase.kde.org/Kio_gopher"

LICENSE="GPL-2"
SLOT="6"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kiconthemes-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
"
RDEPEND="${DEPEND}"
