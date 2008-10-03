# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="koffice"
KMMODULE="libs"
NEED_OPENGL="optional"
NEED_KDE="4.1"
inherit kde4-meta

DESCRIPTION="Shared KOffice libraries."
KEYWORDS="~amd64 ~x86"
IUSE="crypt test" # doc

RDEPEND="
	>=app-office/koffice-data-${PV}:${SLOT}
	dev-libs/libxml2
	dev-libs/libxslt
	>=media-libs/lcms-1.15
	>=media-libs/openexr-1.2.2-r2
	crypt? ( >=app-crypt/qca-2 )
	opengl? ( virtual/opengl virtual/glu )"
DEPEND="${RDEPEND}"
#	doc? ( app-doc/doxygen )"

KMEXTRA="
	doc/koffice/
	doc/thesaurus/
	filters/xsltfilter/
	filters/generic_wrapper/
	interfaces/
	kounavail/
	plugins/
	tools/"
#	doc/api/"
KMEXTRACTONLY="
		kchart/kdchart/
		changes-1.4
		changes-1.5
		doc/koffice.desktop"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DWITH_OpenEXR=ON
		$(cmake-utils_use_with crypt QCA2)
		$(cmake-utils_use_with opengl OpenGL)"

	if use crypt; then
		mycmakeargs="${mycmakeargs}
			-DQCA2_LIBRARIES=/usr/$(get_libdir)/qca2/libqca.so.2"
	fi

	kde4-meta_src_configure
}

src_install() {
	dodoc changes-*
	newdoc kounavail/README README.kounavail

	kde4-meta_src_install

	# remove blocking packages
	rm "${D}"/usr/include/config-openexr.h
	rm "${D}"/usr/share/apps/cmake/modules/FindKOfficeLibs.cmake
}
