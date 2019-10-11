# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="optional"
inherit kde5

DESCRIPTION="FUSE interface for KIO"
HOMEPAGE="https://feverfew.home.blog/2019/09/10/kiofuse-final-report/"

LICENSE="GPL-3+"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	sys-fs/fuse:3
"
RDEPEND="${DEPEND}"
