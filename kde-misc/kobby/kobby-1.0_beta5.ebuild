# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS="fr"
inherit kde4-base

DESCRIPTION="Collaborative Editor for KDE"
HOMEPAGE="http://kobby.greghaynes.net/"
SRC_URI="http://kobby.greghaynes.net/file-cabinet/${P/_beta/b}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	dev-libs/glib:2
	dev-libs/libxml2
	>=net-libs/libqinfinity-${PV}
	>=virtual/gsasl-1.4.0
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P/_beta/b}
