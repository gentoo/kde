# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="forceoptional"
inherit ecm kde.org

DESCRIPTION="KIO Slave and daemon to stash discontinuous file selections"
HOMEPAGE="https://arnavdhamija.com/2017/07/04/kio-stash-shipped/ https://invent.kde.org/utilities/kio-stash"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE=""

RESTRICT+=" test"

DEPEND="
	dev-qt/qtdbus:5
	kde-frameworks/kconfig:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/kdbusaddons:5
	kde-frameworks/ki18n:5
	kde-frameworks/kio:5
"
RDEPEND="${DEPEND}"
