# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="forceoptional"
inherit kde5

DESCRIPTION="KIO Slave and daemon to stash discontinuous file selections"
HOMEPAGE="https://arnavdhamija.com/2017/07/04/kio-stash-shipped/ https://cgit.kde.org/kio-stash.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE=""

RESTRICT+=" test"

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_qt_dep qtdbus)
"
RDEPEND="${DEPEND}"
