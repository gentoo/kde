# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
#KMNAME=koffice
#KMMODULE=koffice
NEED_KDE="svn"
SLOT="kde-svn"
inherit kde4svn

ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/koffice/"

DESCRIPTION="KOffice monolithic live ebuild"
HOMEPAGE="http://www.koffice.org"
KEYWORDS=""
#doc
IUSE="crypt test"
# opengl removed for now
LICENSE="GPL-2 LGPL-2"

RDEPEND="
	!app-office/koffice-libs:${SLOT}
	!app-office/koffice-data:${SLOT}
	dev-libs/libxml2
	dev-libs/libxslt
	>=media-libs/lcms-1.15
	>=media-libs/openexr-1.2.2-r2
	crypt? ( >=app-crypt/qca-2 )
	virtual/opengl
	virtual/glu"
DEPEND="${RDEPEND}"
#	doc? ( app-doc/doxygen )"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DWITH_OpenEXR=ON
		$(cmake-utils_use_with crypt QCA2)
		-DWITH_OpenGL=ON"

	if use crypt; then
		mycmakeargs="${mycmakeargs}
			-DQCA2_LIBRARIES=/usr/$(get_libdir)/qca2/libqca.so.2"
	fi

	kde4overlay-base_src_compile
}

src_install() {
	dodoc changes-*
	newdoc kounavail/README README.kounavail

	kde4overlay-base_src_install
}
