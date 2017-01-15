# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_HANDBOOK="forceoptional"
inherit kde5

DESCRIPTION="Advanced twin-panel (commander-style) file-manager with many extras"
HOMEPAGE="https://krusader.org/"
[[ ${KDE_BUILD_TYPE} = release ]] && SRC_URI="mirror://kde/stable/${PN}/${PV}/${P}.tar.xz"

LICENSE="GPL-2+"
KEYWORDS=""
IUSE="kde"

DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kbookmarks)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep solid)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	sys-apps/acl
	sys-libs/zlib
"
RDEPEND="${DEPEND}
	kde? ( $(add_kdeapps_dep kio-extras) )
	!kde-misc/krusader:4
"

pkg_postinst() {
	kde5_pkg_postinst

	if ! use kde && ! has_version kde-apps/kio-extras:${SLOT} ; then
		elog "Install without USE=kde means missing thumbnails and protocol support (fish, nfs, sftp etc.)!"
	fi

	if ! has_version kde-apps/thumbnailers:${SLOT} ||
			! has_version kde-apps/ffmpegthumbs:${SLOT} ; then
		elog "For PDF/PS, RAW and video thumbnails support, install:"
		elog "   kde-apps/thumbnailers:${SLOT}"
		elog "   kde-apps/ffmpegthumbs:${SLOT}"
	fi

	if ! has_version kde-apps/keditbookmarks:${SLOT} ; then
		elog "For bookmarks support, install kde-apps/keditbookmarks:${SLOT}"
	fi
}
