# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qtscriptgenerator/qtscriptgenerator-0.1.0.ebuild,v 1.2 2009/05/08 01:48:35 loki_val Exp $

EAPI="2"

MY_PN="${PN}-src"
MY_P="${MY_PN}-${PV}"

inherit multilib qt4

DESCRIPTION="Tool for generating Qt bindings for Qt Script"
HOMEPAGE="http://code.google.com/p/qtscriptgenerator/"
SRC_URI="http://qtscriptgenerator.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

DEPEND="
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	|| (
		x11-libs/qt-phonon:4
		media-sound/phonon
	)
	x11-libs/qt-script:4
	x11-libs/qt-sql:4
	x11-libs/qt-svg:4
	x11-libs/qt-webkit:4
	x11-libs/qt-xmlpatterns:4
"
RDEPEND="${DEPEND}"

PLUGINS="core gui network opengl sql svg uitools webkit xml xmlpatterns"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	QTDIR="/usr/include/qt4"
	QTLIBDIR="/usr/$(get_libdir)/qt4/"
}

src_prepare() {
	# remove phonon
	sed -i \
		-e "/typesystem_phonon.xml/d" \
		generator/generator.qrc || die "sed failed"
	sed -i \
		-e "/qtscript_phonon/d" \
		qtbindings/qtbindings.pro || die "sed failed"

	# Fix for GCC-4.4, bug 268086
	epatch "${FILESDIR}/${P}-gcc44.patch"
	qt4_src_prepare
}

src_configure() {
	cd "${S}"/generator
	eqmake4 generator.pro
	cd "${S}"/qtbindings
	eqmake4 qtbindings.pro
}

src_compile() {
	cd "${S}"/generator
	emake || die "emake generator failed"
	./generator --include-paths="/usr/include/qt4/" || die "running generator failed"
	cd "${S}"/qtbindings
	emake || die "make qtbindings failed"
}

src_install() {
	insinto "${QTLIBDIR}"/plugins/script/
	insopts -m0755
	doins -r "${S}"/plugins/script/*.so || die "doins failed"
}
