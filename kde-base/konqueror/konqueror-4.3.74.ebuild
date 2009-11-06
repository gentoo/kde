# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-apps"
inherit kde4-meta

DESCRIPTION="KDE: Web browser, file manager, ..."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="+auth +bookmarks debug +handbook thumbnail"
# 4 of 4 tests fail. Last checked for 4.0.3
RESTRICT="test"

DEPEND="
	$(add_kdebase_dep libkonq)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdebase-kioslaves)
	$(add_kdebase_dep keditfiletype)
	$(add_kdebase_dep kfind)
	$(add_kdebase_dep kfmclient)
	$(add_kdebase_dep kurifilter-plugins)
	auth? ( $(add_kdebase_dep kpasswdserver) )
	bookmarks? ( $(add_kdebase_dep keditbookmarks) )
"
PDEPEND="
	thumbnail? ( $(add_kdebase_dep mplayerthumbs) )
"

KMEXTRACTONLY="
	konqueror/client/
	lib/konq/
"

src_prepare() {
	kde4-meta_src_prepare

	# Do not install *.desktop files for kfmclient
	sed -e "/kfmclient\.desktop/d" -i konqueror/CMakeLists.txt \
		|| die "Failed to omit .desktop files"
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	echo
	elog "If you want to use konqueror as a filemanager, install the dolphin kpart:"
	elog "emerge -1 kde-base/dolphin:${SLOT}"
	elog
	elog "To use Java on webpages: emerge jre"
	echo
}
