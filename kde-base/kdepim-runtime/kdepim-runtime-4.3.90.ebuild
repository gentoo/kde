# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

if [[ ${PV} = *9999* ]]; then
	KMNAME="kdepim"
	KMMODULE="runtime"
	inherit kde4-meta
else
	inherit kde4-base
fi

DESCRIPTION="KDE PIM runtime plugin collection"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	app-misc/strigi
	dev-libs/boost
	dev-libs/libxml2:2
	dev-libs/libxslt
	$(add_kdebase_dep kdelibs 'semantic-desktop')
	$(add_kdebase_dep kdepimlibs 'akonadi')
	$(add_kdebase_dep libkdepim)
	x11-misc/shared-mime-info
"
RDEPEND="${DEPEND}
	>=app-office/akonadi-server-1.2.1
"

add_blocker akonadi '<4.3.85'

[[ ${PV} = *9999* ]] || S="${WORKDIR}/${KMNAME}-${PV}"
