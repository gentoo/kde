# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konqueror/konqueror-4.2.0-r1.ebuild,v 1.1 2009/02/04 18:35:21 scarabeus Exp $

EAPI="2"

KMNAME="kdebase"
KMMODULE="apps/${PN}"
inherit kde4-meta

DESCRIPTION="KDE: Web browser, file manager, ..."
IUSE="+auth +bookmarks debug htmlhandbook"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
# 4 of 4 tests fail. Last checked for 4.0.3
RESTRICT="test"

DEPEND="
	>=kde-base/libkonq-${PV}:${SLOT}
	auth? ( >=kde-base/kpasswdserver-${PV}:${SLOT} )
	bookmarks? ( >=kde-base/keditbookmarks-${PV}:${SLOT} )
"
RDEPEND="${DEPEND}
	>=kde-base/kdebase-kioslaves-${PV}:${SLOT}
	>=kde-base/kfind-${PV}:${SLOT}
	>=kde-base/kurifilter-plugins-${PV}:${SLOT}"

KMEXTRA="apps/doc/${PN}"
KMEXTRACTONLY="apps/lib/konq/"

pkg_postinst() {
	kde4-meta_pkg_postinst

	echo
	elog "If you want to use konqueror as a filemanager, install the dolphin kpart:"
	elog "emerge -1 kde-base/dolphin:${SLOT}"
	elog
	elog "To use Java on webpages: emerge jre"
	echo
}
