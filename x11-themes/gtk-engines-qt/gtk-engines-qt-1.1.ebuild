# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils qt4 cmake-utils

MY_PN="gtk-qt-engine"
DESCRIPTION="GTK+2 Qt4 Theme Engine"
HOMEPAGE="http://gtk-qt.ecs.soton.ac.uk"
SRC_URI="http://gtk-qt.ecs.soton.ac.uk/files/${PV}/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4.1"
IUSE=""

LANGS="bg cs de es fr it nn ru sv tr"
for LANG in ${LANGS}; do
	IUSE="${IUSE} linguas_${LANG}"
done

RDEPEND="|| (
		( >=x11-libs/qt-core-4.4.1:4 >=x11-libs/qt-gui-4.4.1:4 )
		>=x11-libs/qt-4.4.1:4
	)
	x11-libs/gtk+:2
	kde-base/kdebase-data:${SLOT}"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_PN}

src_prepare() {
	epatch "${FILESDIR}/${PV}-stdlib.patch"
	sed -i \
		-e "s:share/locale:/usr/share/locale/:" \
		po/CMakeLists.txt || die "sed install path failed"
	cd "${S}"/po
	# take care of linguas
	for LANG in ${LANGS}; do
		mv "${LANG}".po "${LANG}".po.old
	done
	for LANG in ${LINGUAS}; do
		mv "${LANG}".po.old "${LANG}".po
	done
}

src_configure() {
	# we dont want kdehome or we get sandbox violation
	unset KDEHOME
	# does not support out of tree build
	cmake . || die "cmake failed"
}

src_compile() {
	emake || die "emake failed"
}
