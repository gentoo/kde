# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit eutils qt4 cmake-utils

MY_PN="gtk-qt-engine"
DESCRIPTION="GTK+2 Qt4 Theme Engine"
HOMEPAGE="http://gtk-qt.ecs.soton.ac.uk"
SRC_URI="http://gtk-qt.ecs.soton.ac.uk/files/${PV}/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE=""

LNGS="bg cs de es fr it nn ru sv tr"
for LNG in ${LNGS}; do
	IUSE="${IUSE} linguas_${LNG}"
done

RDEPEND="|| (
		>=x11-libs/qt-4.4.1:4
		( >=x11-libs/qt-core-4.4.1:4 >=x11-libs/qt-gui-4.4.1:4 )
	)
	x11-libs/gtk+:2
	>=kde-base/kdebase-data-4.1.0"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-stdlib.patch"
	sed -i \
		-e "s:share/locale:/usr/share/locale/:" \
		po/CMakeLists.txt || die "sed install path failed"
	cd "${S}"/po
	# take care of linguas
	for LNG in ${LNGS}; do
		mv "${LNG}".po "${LNG}".po.old
	done
	for LNG in ${LINGUAS}; do
		mv "${LNG}".po.old "${LNG}".po
	done
}

src_compile() {
	# we dont want kdehome or we get sandbox violation
	unset ${KDEHOME}
	# does not support out of tree build
	cmake . || die "cmake failed"
	emake || die "emake failed"
}
