# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kde-baseapps"
inherit kde4-meta

DESCRIPTION="A KDE filemanager focusing on usability"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug semantic-desktop thumbnail"

DEPEND="
	$(add_kdebase_dep kdelibs 'semantic-desktop=')
	$(add_kdebase_dep libkonq)
	semantic-desktop? ( >=dev-libs/shared-desktop-ontologies-0.10.0 )
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kfind)
"
PDEPEND="
	thumbnail? (
		$(add_kdebase_dep thumbnailers)
		|| (
			$(add_kdebase_dep ffmpegthumbs)
			$(add_kdebase_dep mplayerthumbs)
		)
	)
"

KMLOADLIBS="libkonq"

RESTRICT="test"
# bug 393129

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with semantic-desktop Nepomuk)
	)

	kde4-meta_src_configure
}

pkg_postinst() {
	kde4-base_pkg_postinst
	echo
	elog "For .exe file preview support, install media-gfx/icoutils."
	echo
}
