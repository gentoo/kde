# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

KMNAME="kdereview"

NEED_KDE="svn"
SLOT="kde-svn"

inherit kde4svn

PREFIX="${KDEDIR}"

DESCRIPTION="Kill the bots or they kill you!"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"

KEYWORDS=""
IUSE=""

DEPEND="kde-base/libkdegames:${SLOT}"
RDEPEND="${DEPEND}"

src_compile() {
	# Installs to the wrong dir otherwise:
	mycmakeargs="${mycmakeargs}
		-DDATA_INSTALL_DIR=${KDEDIR}/share/apps"

	kde4overlay-meta_src_compile
}
