# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM=git
KDE_MINIMAL=4.6
OPENGL_REQUIRED=optional
inherit kde4-base

DESCRIPTION="KDE Office Suite"
HOMEPAGE="http://www.calligra-suite.org/"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="boost crypt eigen exif fftw fontconfig freetds gif glew glib gsf gsl
iconv jpeg jpeg2k +kdcraw kdepim lcms mysql +okular openctl openexr png
+poppler postgres pstoedit semantic-desktop ssl tiff threads truetype
word-perfect xml xslt"

RDEPEND="
	!app-office/koffice-libs
	dev-db/sqlite:3
	dev-lang/perl
	dev-libs/libxml2
	$(add_kdebase_dep knewstuff)
	sys-libs/zlib
	boost? ( dev-libs/boost )
	crypt? ( app-crypt/qca:2 )
	eigen? ( dev-cpp/eigen )
	exif? ( media-gfx/exiv2 )
	fftw? ( sci-libs/fftw:3 )
	fontconfig? ( media-libs/fontconfig )
	freetds? ( dev-db/freetds )
	gif? ( media-libs/giflib )
	glew? ( media-libs/glew )
	glib? ( dev-libs/glib:2 )
	gsf? ( gnome-extra/libgsf )
	gsl? ( sci-libs/gsl )
	iconv? ( virtual/libiconv )
	jpeg? ( virtual/jpeg )
	jpeg2k? ( media-libs/openjpeg )
	kdcraw? ( $(add_kdebase_dep libkdcraw) )
	kdepim? ( $(add_kdebase_dep kdepimlibs) )
	lcms? ( media-libs/lcms:2 )
	mysql? ( virtual/mysql )
	okular? ( $(add_kdebase_dep okular) )
	openctl? ( >=media-libs/opengtl-0.9.15 )
	openexr? ( media-libs/openexr )
	png? ( media-libs/libpng )
	poppler? ( app-text/poppler )
	postgres? ( dev-db/postgresql-base )
	pstoedit? ( media-gfx/pstoedit )
	semantic-desktop? ( dev-libs/soprano )
	ssl? ( dev-libs/openssl )
	tiff? ( media-libs/tiff )
	truetype? ( media-libs/freetype:2 )
	word-perfect? (
		app-text/libwpd
		app-text/libwps
		media-libs/libwpg
	)
	xslt? ( dev-libs/libxslt )
"
DEPEND="${RDEPEND}"

src_configure() {
	# first write out things we want to hard-enable
	local mycmakeargs=(
		"-DWITH_LibXml2=ON" # harddep for few parts
		"-DWITH_ZLIB=ON"
		"-DGHNS=ON"
		"-DWITH_X11=ON"
		"-DWITH_Qt4=ON"
	)

	# default disablers
	mycmakeargs+=(
		"-DWITH_LCMS=OFF" # we use lcms:2
		"-DWITH_XBase=OFF" # i am not the one to support this
		"-DCREATIVEONLY=OFF"
		"-DWITH_TINY=OFF"
		"-DWITH_CreateResources=OFF" # NOT PACKAGED: http://create.freedesktop.org/
		"-DWITH_DCMTK=OFF" # NOT PACKAGED: http://www.dcmtk.org/dcmtk.php.en
		"-DWITH_Spnav=OFF" # NOT PACKAGED: http://spacenav.sourceforge.net/
	)

	# regular options
	mycmakeargs+=(
		$(cmake-utils_use_with boost Boost)
		$(cmake-utils_use_with crypt QCA2)
		$(cmake-utils_use_with eigen Eigen2)
		$(cmake-utils_use_with exif Exiv2)
		$(cmake-utils_use_with fftw FFTW3)
		$(cmake-utils_use_with fontconfig Fontconfig)
		$(cmake-utils_use_with freetds FreeTDS)
		$(cmake-utils_use_with gif GIF2)
		$(cmake-utils_use_with glew GLEW)
		$(cmake-utils_use_with glib GLIB2)
		$(cmake-utils_use_with glib GObject)
		$(cmake-utils_use_with gsf LIBGSF)
		$(cmake-utils_use_with gsl GSL)
		$(cmake-utils_use_with iconv Iconv)
		$(cmake-utils_use_with jpeg JPEG)
		$(cmake-utils_use_with jpeg2k OpenJPEG)
		$(cmake-utils_use_with kdcraw Kdcraw)
		$(cmake-utils_use_with kdepim KdepimLibs)
		$(cmake-utils_use_with lcms LCMS2)
		$(cmake-utils_use_with mysql MySQL)
		$(cmake-utils_use_with okular Okular)
		$(cmake-utils_use_with openctl OpenCTL)
		$(cmake-utils_use_with openexr OpenEXR)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with png PNG)
		$(cmake-utils_use_with poppler Poppler)
		$(cmake-utils_use_with postgres PostgreSQL)
		$(cmake-utils_use_with pstoedit Pstoedit)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with ssl OpenSSL)
		$(cmake-utils_use_with tiff TIFF)
		$(cmake-utils_use_with threads Threads)
		$(cmake-utils_use_with truetype Freetype)
		$(cmake-utils_use_with word-perfect WPD)
		$(cmake-utils_use_with word-perfect WPG)
		$(cmake-utils_use_with xslt LibXslt)
	)

	# applications

	# filters

	kde4-base_src_configure
}
