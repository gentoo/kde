# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit multilib git qt4

DESCRIPTION="Tool for generating Qt bindings for Qt Script"
HOMEPAGE="http://code.google.com/p/qtscriptgenerator/"
EGIT_REPO_URI="git://gitorious.org/qt-labs/qtscriptgenerator.git"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	x11-libs/qt-script:4
	x11-libs/qt-sql:4
	x11-libs/qt-svg:4
	x11-libs/qt-webkit:4
	x11-libs/qt-xmlpatterns:4"
RDEPEND="${DEPEND}"

PLUGINS="core gui network opengl sql svg uitools webkit xml xmlpatterns"

src_unpack() {
	git_src_unpack
}

src_prepare() {
	# remove phonon
	sed -i "/typesystem_phonon.xml/d" generator/generator.qrc \
		|| die "sed failed"
	sed -i "/qtscript_phonon/d" qtbindings/qtbindings.pro \
		|| die "sed failed"

	epatch "${FILESDIR}/${PN}-gcc44.patch"
	git_src_prepare
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
	insinto /usr/$(get_libdir)/qt4/plugins/script/
	insopts -m0755
	doins -r "${S}"/plugins/script/*.so || die "doins failed"
}
