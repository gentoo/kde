# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} = *9999* ]]; then
	KMNAME="kdepim"
	KMMODULE="runtime"
	inherit kde4-meta
else
	inherit kde4-base
fi

DESCRIPTION="KDE PIM runtime plugin collection"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RESTRICT="test"
# Would need test programs _testrunner and akonaditest from kdepimlibs

COMMON_DEPEND="
	app-misc/strigi
	>=app-office/akonadi-server-1.3.1
	dev-libs/libxml2:2
	dev-libs/libxslt
	$(add_kdebase_dep kdelibs 'semantic-desktop' 4.12)
	$(add_kdebase_dep kdepimlibs '' 4.12)
	$(add_kdebase_dep libkdepim)
	x11-misc/shared-mime-info
"
DEPEND="${COMMON_DEPEND}
	dev-libs/boost
"
RDEPEND="${COMMON_DEPEND}
	$(add_kdebase_dep kdepim-icons)
"

add_blocker akonadi '<4.3.90'

PATCHES=(
	"${FILESDIR}/4.4/"000[1-2]-*.patch
	"${FILESDIR}/4.4/"999[6-9]-*.patch
)
