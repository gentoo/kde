# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kde-baseapps"
inherit kde4-meta

DESCRIPTION="Various plugins for konqueror"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug tidy"

DEPEND="
	$(add_kdebase_dep libkonq)
	tidy? ( app-text/htmltidy )
"
RDEPEND="${DEPEND}
	!kde-misc/konq-plugins
	$(add_kdebase_dep kcmshell)
	$(add_kdebase_dep konqueror)
"

src_configure() {
	local mycmakeargs=(
		-DKdeWebKit=OFF
		-DWebKitPart=OFF
		$(cmake-utils_use_with tidy LibTidy)
	)

	kde4-meta_src_configure
}
