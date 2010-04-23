# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

PYTHON_DEPEND="2:2.6"

inherit cmake-utils fdo-mime multilib python subversion

DESCRIPTION="Desktop Publishing (DTP) and Layout program for Linux."
HOMEPAGE="http://www.scribus.net/"
#SRC_URI="mirror://sourceforge/${PN}/${P/_/.}.7z"

ESVN_REPO_URI="svn://scribus.info/Scribus/trunk/Scribus"
ESVN_PROJECT="scribus"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="cairo cups debug +pdf spell"

COMMON_DEPEND="
	dev-libs/hyphen
	dev-libs/libxml2
	media-libs/fontconfig
	>=media-libs/freetype-2
	media-libs/jpeg:0
	media-libs/lcms
	media-libs/libpng
	media-libs/tiff
	net-print/cups
	sys-libs/zlib
	x11-libs/qt-gui:4
	spell? ( app-text/aspell )
	pdf? ( app-text/podofo )
	cairo? ( x11-libs/cairo[X,svg] )
"
RDEPEND="${COMMON_DEPEND}
	app-text/ghostscript-gpl
"
DEPEND="${COMMON_DEPEND}
	dev-libs/boost"

S="${WORKDIR}/${P/_/.}"

pkg_setup() {
	python_set_active_version 2
}

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
#	sed	-e "s:LIB_TYPE STATIC:LIB_TYPE SHARED:g" \
#		-i scribus/plugins/tools/2geomtools/lib2geom/CMakeLists.txt \
#		|| die "fixing static libs failed"
}

src_configure() {
	# cairo can be used as replacement instead of qt arthur
	mycmakeargs=(
		-DHAVE_PYTHON=ON
		-DPYTHON_INCLUDE_PATH=$(python_get_includedir)
		-DPYTHON_LIBRARY=$(python_get_library)
		-DWANT_NORPATH=ON
		-DWANT_QTARTHUR=ON
		-DWANT_QT3SUPPORT=OFF
		$(cmake-utils_use_has spell ASPELL)
		$(cmake-utils_use_has pdf podofo)
		$(cmake-utils_use_want cairo)
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	domenu "${S}/${PN}.desktop" || die "domenu failed"
	doicon "${S}/resources/icons/scribus.png" || die "doicon failed"
}

pkg_postinst() {
	fdo-mime_mime_database_update
}

pgk_postrm() {
	fdo-mime_mime_database_update
}
