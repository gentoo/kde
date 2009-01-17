# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-qt/gtk-engines-qt-1.1.ebuild,v 1.3 2008/11/15 21:46:39 vapier Exp $

EAPI="2"

KDE_LINGUAS="bg cs de es fr it nn ru sv tr"
inherit kde4-base

MY_PN="gtk-qt-engine"
DESCRIPTION="GTK+2 Qt4 Theme Engine"
HOMEPAGE="http://gtk-qt.ecs.soton.ac.uk"
SRC_URI="http://gtk-qt.ecs.soton.ac.uk/files/${PV}/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
SLOT="1"
IUSE="gnome"

RDEPEND="x11-libs/gtk+:2
	!kdeprefix? ( !x11-themes/gtk-engines-qt:4.1 )
	gnome? ( =gnome-base/libbonoboui-2* )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_PN}

CMAKE_IN_SOURCE_BUILD="1"

src_prepare() {
	epatch "${FILESDIR}/${PV}-stdlib.patch"
	sed -i \
		-e "s:\${XDG_APPS_INSTALL_DIR}:${KDEDIR}/share/kde4/services/:g" \
		kcm_gtk/CMakeLists.txt || die "replacing correct folder failed"

	kde4-base_src_prepare
}

src_configure() {
	# BONOBOUI is automagic
	cmake-utils_src_configure
}
