# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="Libraries and daemons to implement searching in Akonadi"
HOMEPAGE="https://projects.kde.org/projects/playground/pim/akonadi-search"
KEYWORDS="~amd64 ~x86"
IUSE=""

# TODO check if newer xapian is working
RDEPEND="
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_kdeapps_dep kcalcore)
	$(add_kdeapps_dep kcontacts)
	$(add_kdeapps_dep kdepimlibs)
	$(add_kdeapps_dep kmime)
	=dev-libs/xapian-1.2*[chert]
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
"
DEPEND="${RDEPEND}
	dev-libs/boost
"
