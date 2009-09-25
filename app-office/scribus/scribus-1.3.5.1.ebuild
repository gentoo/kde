# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils multilib

DESCRIPTION="Desktop Publishing (DTP) and Layout program for Linux."
HOMEPAGE="http://www.scribus.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/_/.}.7z"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cairo cups debug +podofo python spell"

COMMONDEPEND="
	dev-libs/boost
	dev-libs/libxml2
	media-libs/fontconfig
	>=media-libs/freetype-2.3.7
	media-libs/jpeg
	media-libs/lcms
	media-libs/libpng
	media-libs/tiff
	net-print/cups
	sys-libs/zlib
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-sql:4
	x11-libs/qt-xmlpatterns:4
	cairo? ( x11-libs/cairo[X,svg] )
	podofo? ( app-text/podofo )
	spell? ( app-text/aspell )
"
DEPEND="${COMMONDEPEND}
	app-arch/p7zip
"
RDEPEND="${COMMONDEPEND}
	virtual/ghostscript
"

S="${WORKDIR}/${P/_/.}"

src_prepare() {
	# fix libdir detection
	# fix docdir
	# fix tag appending to folder
	# build 2geom and toy as shared things
	sed -i \
		-e "s:doc/\${MAIN_DIR_NAME}\${TAG_VERSION}/\":doc/${PF}/\":g" \
		-e "s:doc/\${MAIN_DIR_NAME}-\${VERSION}/\":doc/${PF}/\":g" \
		-e "s:\${MAIN_DIR_NAME}\${TAG_VERSION}:\${MAIN_DIR_NAME}:g" \
		CMakeLists.txt || die "fixing libdir failed"
	# build 2geom and toy as shared things
	sed	-i \
		-e "s:LIB_TYPE STATIC:LIB_TYPE SHARED:g" \
		scribus/plugins/tools/2geomtools/lib2geom/CMakeLists.txt \
		|| die "fixing static libs failed"
#		-e "s:^#FILE:FILE:g" \
#		-e "s:^#INSTALL(FILES \$:INSTALL(FILES \$:g" \
#		scribus/plugins/tools/2geomtools/lib2geom/CMakeLists.txt \
#		|| die "fixing static libs failed"
#	echo -e "\ninstall(TARGETS 2geom LIBRARY DESTINATION \${PLUGINDIR} PERMISSIONS \${PLUGIN_PERMISSIONS})" \
#		>> scribus/plugins/tools/2geomtools/lib2geom/CMakeLists.txt
}

src_configure() {
	# cairo can be used as replacement instead of qt arthur
	mycmakeargs="${mycmakeargs}
		-D2GEOM_BUILD_SHARED=ON
		-DHAVE_CMS=ON
		-DHAVE_FONTCONFIG=ON
		-DHAVE_LIBZ=ON
		-DHAVE_TIFF=ON
		-DHAVE_XML=ON
		-DWANT_NORPATH=ON
		-DWANT_QTARTHUR=ON
		-DWANT_QT3SUPPORT=OFF
		$(cmake-utils_use_has podofo)
		$(cmake-utils_use_has python)
		$(cmake-utils_use_has spell ASPELL)
		$(cmake-utils_use_want cairo)"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	domenu "${S}/${PN}.desktop" || die "domenu failed"
	doicon "${S}/scribus/icons/scribus.png" || die "doicon failed"
}
