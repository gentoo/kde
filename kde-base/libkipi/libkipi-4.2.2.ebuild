# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkipi/libkipi-4.2.1.ebuild,v 1.1 2009/03/04 22:40:40 alexxy Exp $

EAPI="2"

KMNAME="kdegraphics"
KMMODULE="libs/${PN}"

inherit kde4-meta

DESCRIPTION="A library for image plugins accross KDE applications."
HOMEPAGE="http://www.kipi-plugins.org"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

RDEPEND="
	!kdeprefix? ( !<=media-libs/libkipi-0.1.6 )
"
