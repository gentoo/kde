# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Based in parts upon a work of individual contributors of the genkdesvn project

EAPI="2"

KMNAME="kdeaccessibility"
inherit kde4-meta

DESCRIPTION="KDE: A type-and-say front end for speech synthesizers"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc"

pkg_postinst() {
	kde4-meta_pkg_postinst

	echo
	elog "Suggested: kde-base/kttsd:${SLOT}"
	echo
}
