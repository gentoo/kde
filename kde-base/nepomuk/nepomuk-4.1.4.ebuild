# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nepomuk/nepomuk-4.1.3.ebuild,v 1.2 2008/11/16 08:23:44 vapier Exp $

EAPI="2"

KMNAME=kdebase-runtime
inherit kde4-meta

DESCRIPTION="Nepomuk KDE4 client"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

# dev-cpp/clucene provides the optional strigi backend.
# As there's currently no other *usable* strigi backend, I've added it as a hard
# dependency.
DEPEND=">=app-misc/strigi-0.5.10[qt4]
	dev-cpp/clucene
	>=dev-libs/soprano-2.0.98[clucene]"
RDEPEND="${DEPEND}
	kde-base/kdelibs[semantic-desktop]"
