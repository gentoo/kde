# Copyright 1999-2009 Gentoo Foundation
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
IUSE="+crypt +openexr"

RDEPEND="
	>=app-office/koffice-data-${PV}:${SLOT}[kdeprefix=]
	dev-libs/libxml2
	dev-libs/libxslt
	>=kde-base/kdepimlibs-${KDE_MINIMAL}[kdeprefix=]
	>=media-libs/lcms-1.15
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
	filters/xsltfilter/
	interfaces/
	kounavail/
	plugins/
	tools/"
#	doc/api/"
KMEXTRACTONLY="
	doc/koffice.desktop"

KMSAVELIBS="true"

src_prepare() {
	sed -i \
		-e "s:QtCrypto/QtCrypto:QtCrypto:" \
		libs/store/KoEncryptedStore.h || die

	kde4-meta_src_prepare
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with crypt QCA2)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with openexr OpenEXR)"
	use crypt && mycmakeargs="${mycmakeargs}
		-DQCA2_LIBRARIES=/usr/$(get_libdir)/qca2/libqca.so.2"

	kde4-base_src_configure
}

src_install() {
	newdoc kounavail/README README.kounavail

	kde4-meta_src_install
}
