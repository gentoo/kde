# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

if [[ ${PV} = *9999* ]]; then
	KMNAME="kdepim"
	KMMODULE="runtime"
	eclass="kde4-meta"
else
	eclass="kde4-base"
fi
inherit ${eclass}

DESCRIPTION="KDE PIM runtime plugin collection"
KEYWORDS=""
IUSE="debug +semantic-desktop"

DEPEND="
	app-misc/strigi
	dev-libs/boost
	dev-libs/libxml2:2
	dev-libs/libxslt
	>=dev-libs/shared-desktop-ontologies-0.2
	$(add_kdebase_dep kdelibs 'semantic-desktop?')
	$(add_kdebase_dep libkdepim)
	x11-misc/shared-mime-info
"
RDEPEND="${DEPEND}
	>=app-office/akonadi-server-1.2.1
"

add_blocker akonadi '<4.3.85'

[[ ${eclass} = "kde4-base" ]] && S="${WORKDIR}/${KMNAME}-${PV}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use semantic-desktop KDEPIM_BUILD_NEPOMUK_AGENTS)
	)
	${eclass}_src_configure
}
