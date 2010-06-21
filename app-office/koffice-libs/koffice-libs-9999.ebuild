# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="koffice"
KMMODULE="libs"
OPENGL_REQUIRED="optional"
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="Shared KOffice libraries."
KEYWORDS=""
IUSE="crypt openexr"

RDEPEND="
	>=app-office/koffice-data-${PV}:${SLOT}
	dev-libs/libxml2
	dev-libs/libxslt
	>=kde-base/kdepimlibs-${KDE_MINIMAL}
	media-libs/lcms:0
	crypt? ( app-crypt/qca:2 )
	openexr? ( media-libs/openexr )
	opengl? ( media-libs/mesa )
"
DEPEND="${RDEPEND}"
#	doc? ( app-doc/doxygen )"

KMEXTRA="
	doc/koffice/
	doc/thesaurus/
	filters/generic_wrapper/
	filters/libkowmf/
	filters/libmsooxml/
	filters/xsltfilter/
	filters/kspread/
	kspread/
	interfaces/
	kounavail/
	plugins/
	tools/
"
#	doc/api/"
KMEXTRACTONLY="
	doc/koffice.desktop
	kchart/
	filters/liboofilter/
"

KMSAVELIBS="true"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with crypt QCA2)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with openexr OpenEXR)
	)
	use crypt && \
		mycmakeargs+=(-DQCA2_LIBRARIES=/usr/$(get_libdir)/qca2/libqca.so.2)

	kde4-meta_src_configure
}

src_install() {
	newdoc kounavail/README README.kounavail || die

	kde4-meta_src_install
}
