# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kde-baseapps"
inherit flag-o-matic kde4-meta

DESCRIPTION="KDE: Web browser, file manager, ..."
HOMEPAGE="
	http://www.kde.org/applications/internet/konqueror/
	http://konqueror.org/
"
KEYWORDS=""
IUSE="+bookmarks debug svg"
# 4 of 4 tests fail. Last checked for 4.0.3
RESTRICT="test"

DEPEND="
	$(add_kdebase_dep libkonq)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kfind)
	$(add_kdebase_dep kfmclient)
	bookmarks? ( $(add_kdebase_dep keditbookmarks) )
	svg? ( $(add_kdebase_dep svgpart) )
"

KMEXTRACTONLY="
	konqueror/client/
	lib/konq/
"

src_prepare() {
	[[ ${CHOST} == *-solaris* ]] && append-ldflags -lmalloc

	kde4-meta_src_prepare

	# Do not install *.desktop files for kfmclient
	sed -e "/kfmclient\.desktop/d" -i konqueror/CMakeLists.txt \
		|| die "Failed to omit .desktop files"
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	if ! has_version kde-base/dolphin:${SLOT} ; then
		elog "If you want to use konqueror as a filemanager, install the dolphin kpart:"
		elog "kde-base/dolphin:${SLOT}"
	fi

	if ! has_version virtual/jre ; then
		elog "To use Java on webpages install virtual/jre."
	fi
}
