# Copyright 1999-2008 Gentoo Foundation             
# Distributed under the terms of the GNU General Public License v2
# $Header: $                                                      

EAPI="1"

KMNAME="extragear/network"
NEED_KDE="svn"            
inherit kde4svn-meta      

# Install to KDEDIR rather than /usr, to slot properly.
PREFIX="${KDEDIR}" 

DESCRIPTION="Provides integration for the MLDonkey P2P software and KDE 4."
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"

KEYWORDS=""
SLOT="kde-svn"
IUSE="debug plasma"

PREFIX="${KDEDIR}"

RDEPEND="plasma? ( kde-base/libplasma:${SLOT} )"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_compile() {
	sed -e '/SSH2/ s:^:#DONOTWANT:' \
		-i "${S}"/CMakeLists.txt \
		|| die "Deactivating search for SSH2 failed."

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with plasma Plasma)"

	kde4overlay-meta_src_compile
}
