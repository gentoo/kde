# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib qt4-r2 git-r3

DESCRIPTION="Tool for generating Qt bindings for Qt Script"
HOMEPAGE="http://code.google.com/p/qtscriptgenerator/"
EGIT_REPO_URI=( "git://gitorious.org/qt-labs/qtscriptgenerator.git" )

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

DEPEND="dev-qt/qtcore:4
	dev-qt/designer:4
	dev-qt/qtgui:4
	dev-qt/qtopengl:4
	dev-qt/qtscript:4
	dev-qt/qtsql:4
	dev-qt/qtsvg:4
	dev-qt/qtwebkit:4
	dev-qt/qtxmlpatterns:4"
RDEPEND="${DEPEND}"

PLUGINS="core gui network opengl sql svg uitools webkit xml xmlpatterns"

# Fix for GCC-4.4 (bug 268086), Qt 4.8 (bug 397917)
PATCHES=(
	"${FILESDIR}/${PN}-gcc44.patch"
)

src_prepare() {
	# remove phonon
	sed -i "/typesystem_phonon.xml/d" generator/generator.qrc \
		|| die "sed failed"
	sed -i "/qtscript_phonon/d" qtbindings/qtbindings.pro \
		|| die "sed failed"

	qt4-r2_src_prepare
}

src_configure() {
	cd "${S}"/generator
	eqmake4 generator.pro
	cd "${S}"/qtbindings
	eqmake4 qtbindings.pro
}

src_compile() {
	cd "${S}"/generator
	emake
	./generator --include-paths="${EPREFIX}/usr/include/qt4/" || die "running generator failed"

	cd "${S}"/qtbindings
	emake
}

src_install() {
	insinto /usr/$(get_libdir)/qt4/plugins/script/
	insopts -m0755
	doins -r "${S}"/plugins/script/* || die "doins failed"
}
