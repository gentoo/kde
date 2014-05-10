# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils toolchain-funcs git-r3

DESCRIPTION="PDF rendering library based on the xpdf-3.0 code base"
HOMEPAGE="http://poppler.freedesktop.org/"
EGIT_REPO_URI="git://git.freedesktop.org/git/${PN}/${PN}"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0/46"
IUSE="cairo cjk curl cxx debug doc +introspection +jpeg jpeg2k +lcms png qt4 tiff +utils"

# No test data provided
RESTRICT="test"

COMMON_DEPEND="
	>=media-libs/fontconfig-2.6.0
	>=media-libs/freetype-2.3.9
	sys-libs/zlib
	cairo? (
		dev-libs/glib:2
		>=x11-libs/cairo-1.10.0
		introspection? ( >=dev-libs/gobject-introspection-1.32.1 )
	)
	curl? ( net-misc/curl )
	jpeg? ( virtual/jpeg:0 )
	jpeg2k? ( media-libs/openjpeg:0 )
	lcms? ( media-libs/lcms:2 )
	png? ( media-libs/libpng:0= )
	qt4? (
		dev-qt/qtcore:4
		dev-qt/qtgui:4
	)
	tiff? ( media-libs/tiff:0 )
"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
"
RDEPEND="${COMMON_DEPEND}
	cjk? ( >=app-text/poppler-data-0.4.4 )
"

DOCS=(AUTHORS NEWS README README-XPDF TODO)

src_configure() {
	# this is needed for multilib, see bug 459394
	local ft_libdir ft_includedir
	ft_libdir="$($(tc-getPKG_CONFIG) freetype2 --variable=libdir)"
	ft_includedir="$($(tc-getPKG_CONFIG) freetype2 --variable=includedir)"
	export FREETYPE_DIR="${ft_libdir}:${ft_includedir%/include}"
	einfo "Detected FreeType at ${FREETYPE_DIR}"

	mycmakeargs=(
		-DBUILD_GTK_TESTS=OFF
		-DBUILD_QT4_TESTS=OFF
		-DBUILD_QT5_TESTS=OFF
		-DBUILD_CPP_TESTS=OFF
		-DENABLE_SPLASH=ON
		-DENABLE_ZLIB=ON
		-DENABLE_XPDF_HEADERS=ON
		$(cmake-utils_use_enable curl LIBCURL)
		$(cmake-utils_use_enable cxx CPP)
		$(cmake-utils_use_enable jpeg2k LIBOPENJPEG)
		$(cmake-utils_use_enable utils)
		$(cmake-utils_use_with cairo)
		$(cmake-utils_use_with introspection GObjectIntrospection)
		$(cmake-utils_use_with jpeg)
		$(cmake-utils_use_with png)
		$(cmake-utils_use_with qt4)
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Core=ON
		$(cmake-utils_use_with tiff)
	)
	if use lcms; then
		mycmakeargs+=(-DENABLE_CMS=lcms2)
	else
		mycmakeargs+=(-DENABLE_CMS=)
	fi

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	if use cairo && use doc; then
		# For now install gtk-doc there
		insinto /usr/share/gtk-doc/html/poppler
		doins -r "${S}"/glib/reference/html/*
	fi
}
