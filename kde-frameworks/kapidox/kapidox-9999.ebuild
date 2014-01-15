# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_DEBUG="false"
FRAMEWORKS_DOXYGEN="false"
FRAMEWORKS_TEST="false"
inherit kde-frameworks

DESCRIPTION="Framework for building KDE API documentation in a standard format and style"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS=""
IUSE=""

RDEPEND="
	app-doc/doxygen
"

src_install() {
	insinto /usr/share/${PN}
	doins src/*.local src/*.sh

	docompress -x /usr/share/doc/HTML/en/common
	insinto /usr/share/doc/HTML/en/common
	doins common/{api_searchbox.html,Doxyfile.global,flat.css,kde-localised.css.template}
	doins common/{kde.css,kde_logo.png,kmenu.png,print.css}

	kde-frameworks_src_install
}
