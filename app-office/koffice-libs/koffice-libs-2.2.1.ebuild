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
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="crypt openexr reports"

# the contents of kchart have been _temporarily_ moved into koffice-libs in 2.2.0

RDEPEND="
	>=app-office/koffice-data-${PV}:${SLOT}
	dev-libs/libxml2
	dev-libs/libxslt
	>=kde-base/kdepimlibs-${KDE_MINIMAL}
	media-libs/lcms:0
	crypt? ( app-crypt/qca:2 )
	openexr? ( media-libs/openexr )
	opengl? ( media-libs/mesa )
	!<app-office/kchart-2.2.0
"
DEPEND="${RDEPEND}"
#	doc? ( app-doc/doxygen )"

PATCHES=( "${FILESDIR}/${P}-kspreadcommon.patch" )

KMEXTRA="
	doc/koffice/
	doc/thesaurus/
	filters/generic_wrapper/
	filters/libkowmf/
	filters/libmsooxml/
	filters/xsltfilter/
	filters/kchart/
	interfaces/
	kounavail/
	plugins/
	tools/
	kchart/
"
#	doc/api/"
KMEXTRACTONLY="
	doc/koffice.desktop
	filters/
"

KMSAVELIBS="true"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with crypt QCA2)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with openexr OpenEXR)
		-DBUILD_kchart=ON
		$(cmake-utils_use_build reports koreport)
	)
	use crypt && \
		mycmakeargs+=(-DQCA2_LIBRARIES=/usr/$(get_libdir)/qca2/libqca.so.2)

	kde4-meta_src_configure
}

src_install() {
	newdoc kounavail/README README.kounavail || die

	kde4-meta_src_install

	# this is already installed by koffice-data
	rm -f "${D}/usr/include/config-opengl.h"
}
