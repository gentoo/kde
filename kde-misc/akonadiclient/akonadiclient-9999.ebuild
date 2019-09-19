# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional"
KDE_TEST="forceoptional"
inherit kde5

DESCRIPTION="Commandline interface for accessing Akonadi"
HOMEPAGE="https://cgit.kde.org/akonadiclient.git/"
LICENSE="GPL-2"

KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcontacts)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_kdeapps_dep akonadi 'xml')
	$(add_qt_dep qtwidgets)
"
RDEPEND="${DEPEND}"

src_prepare() {
	cmake-utils_src_prepare
	punt_bogus_dep KF5 KIO	# we don't need it with >=Qt-5.10
}
