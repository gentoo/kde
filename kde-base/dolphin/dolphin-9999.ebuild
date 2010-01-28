# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-apps"
inherit kde4-meta

DESCRIPTION="A KDE filemanager focusing on usability"
KEYWORDS=""
IUSE="debug +handbook semantic-desktop subversion thumbnail"

DEPEND="
	$(add_kdebase_dep kdelibs 'semantic-desktop?')
	$(add_kdebase_dep libkonq)
	semantic-desktop? ( >=dev-libs/shared-desktop-ontologies-0.2 )
"
RDEPEND="${DEPEND}
	subversion? ( dev-util/subversion )
	$(add_kdebase_dep kfind)
"
PDEPEND="
	thumbnail? ( $(add_kdebase_dep mplayerthumbs) )
"

KMLOADLIBS="libkonq"

src_prepare() {
	kde4-meta_src_prepare

	if ! use subversion; then
		sed -e '/install(.*fileviewsvnplugin.*)/s/^/#DONOTINSTALL /g' \
			-i dolphin/src/CMakeLists.txt || die 'failed to disable subversion plugin'
	fi
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with semantic-desktop Nepomuk)
	)

	kde4-meta_src_configure
}
