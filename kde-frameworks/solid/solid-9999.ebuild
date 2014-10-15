# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Framework providing platform independent hardware discovery, abstraction, and management"
LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE="nls"

RDEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	virtual/udev
"
DEPEND="${RDEPEND}
	nls? ( dev-qt/linguist-tools:5 )
	test? ( dev-qt/qtconcurrent:5 )
"
pkg_postinst() {
	kde5_pkg_postinst

	if ! has_version "app-misc/media-player-info" ; then
		einfo "For media player support, install app-misc/media-player-info"
	fi
}
