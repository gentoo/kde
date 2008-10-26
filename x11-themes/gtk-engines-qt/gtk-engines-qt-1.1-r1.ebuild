# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

NEED_KDE=":4.1"
KDE_LINGUAS="bg cs de es fr it nn ru sv tr"
inherit kde4-base

MY_PN="gtk-qt-engine"
DESCRIPTION="GTK+2 Qt4 Theme Engine"
HOMEPAGE="http://gtk-qt.ecs.soton.ac.uk"
SRC_URI="http://gtk-qt.ecs.soton.ac.uk/files/${PV}/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4.1"
IUSE="gnome"

RDEPEND="x11-libs/gtk+:2
	gnome? ( =gnome-base/libbonoboui-2* )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_PN}

src_prepare() {
	epatch "${FILESDIR}/${PV}-stdlib.patch"
}

src_configure() {
	# does not support out of tree build, BONOBOUI is automagic
	cmake . -DCMAKE_INSTALL_PREFIX=${KDEDIR} || die "cmake failed"
}
