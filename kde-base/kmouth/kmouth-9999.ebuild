# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeaccessibility"
inherit kde4-meta

DESCRIPTION="KDE: A type-and-say front end for speech synthesizers"
KEYWORDS=""
IUSE="debug doc"

pkg_postinst() {
	kde4-meta_pkg_postinst

	echo
	elog "Suggested: kde-base/kttsd:${SLOT}"
	echo
}
