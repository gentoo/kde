# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmouth/kmouth-4.2.1.ebuild,v 1.1 2009/03/04 21:51:30 alexxy Exp $

EAPI="2"

KMNAME="kdeaccessibility"
inherit kde4-meta

DESCRIPTION="KDE: A type-and-say front end for speech synthesizers"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

pkg_postinst() {
	kde4-meta_pkg_postinst
	elog "Suggested: kde-base/kttsd:${SLOT}"
}
