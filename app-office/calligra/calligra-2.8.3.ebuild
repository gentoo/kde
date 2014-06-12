# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/calligra/calligra-2.8.2.ebuild,v 1.2 2014/05/24 11:28:43 johu Exp $

# note: files that need to be checked for dependencies etc:
# CMakeLists.txt, kexi/CMakeLists.txt kexi/migration/CMakeLists.txt
# krita/CMakeLists.txt

EAPI=5

OPENGL_REQUIRED=optional
KDE_HANDBOOK=optional
KDE_LINGUAS_LIVE_OVERRIDE=true
CHECKREQS_DISK_BUILD="4G"
KDE_MINIMAL="4.13.1"
inherit check-reqs kde4-base versionator

DESCRIPTION="KDE Office Suite"
HOMEPAGE="http://www.calligra.org/"

case ${PV} in
	2.[456789].[789]?)
		# beta or rc releases
		SRC_URI="mirror://kde/unstable/${P}/${P}.tar.xz" ;;
	2.[456789].?)
		# stable releases
		SRC_URI="mirror://kde/stable/${P}/${P}.tar.xz" ;;
	2.[456789].9999)
		# stable branch live ebuild
		SRC_URI="" ;;
	9999)
		# master branch live ebuild
		SRC_URI="" ;;
esac

LICENSE="GPL-2"
SLOT="4"

# Don't move KEYWORDS on the previous line or ekeyword won't work # 399061
[[ ${PV} == *9999 ]] || \
KEYWORDS="~amd64 ~arm ~x86"

IUSE="attica +crypt +eigen +exif fftw +fontconfig freetds +gif +glew +glib +gsf
gsl import-filter +jpeg jpeg2k +kdcraw kde +kdepim +lcms marble mysql nepomuk
+okular opengtl openexr +pdf postgres spacenav +ssl sybase test tiff +threads
+truetype vc xbase +xml +xslt"

# please do not sort here, order is same as in CMakeLists.txt
CAL_FTS="author kexi words flow plan stage sheets krita karbon braindump"
for cal_ft in ${CAL_FTS}; do
	IUSE+=" calligra_features_${cal_ft}"
done
unset cal_ft

REQUIRED_USE="
	calligra_features_author? ( calligra_features_words )
	calligra_features_kexi? ( calligra_features_sheets )
	calligra_features_words? ( calligra_features_sheets )
	calligra_features_krita? ( eigen exif glew lcms )
	calligra_features_plan? ( kdepim )
	calligra_features_sheets? ( eigen )
	vc? ( calligra_features_krita )
	test? ( calligra_features_karbon )
"

RDEPEND="
	!app-office/karbon
	!app-office/kexi
	!app-office/koffice-data
	!app-office/koffice-l10n
	!app-office/koffice-libs
	!app-office/koffice-meta
	!app-office/kplato
	!app-office/kpresenter
	!app-office/krita
	!app-office/kspread
	!app-office/kword
	$(add_kdebase_dep kdelibs 'nepomuk?')
	dev-lang/perl
	dev-libs/boost
	dev-libs/libxml2
	$(add_kdebase_dep knewstuff)
	media-libs/libpng
	sys-libs/zlib
	>=dev-qt/qtgui-4.8.1-r1:4
	virtual/libiconv
	attica? ( dev-libs/libattica )
	crypt? ( app-crypt/qca:2 )
	eigen? ( dev-cpp/eigen:2 )
	exif? ( media-gfx/exiv2:= )
	fftw? ( sci-libs/fftw:3.0 )
	fontconfig? ( media-libs/fontconfig )
	freetds? ( dev-db/freetds )
	gif? ( media-libs/giflib )
	glew? ( media-libs/glew )
	glib? ( dev-libs/glib:2 )
	gsf? ( gnome-extra/libgsf )
	gsl? ( sci-libs/gsl )
	import-filter? (
		app-text/libetonyek
		app-text/libodfgen
		app-text/libwpd
		app-text/libwpg
		app-text/libwps
		media-libs/libvisio
	)
	jpeg? ( virtual/jpeg:0 )
	jpeg2k? ( media-libs/openjpeg:0 )
	kdcraw? ( $(add_kdebase_dep libkdcraw) )
	kde? ( $(add_kdebase_dep kactivities) )
	kdepim? ( $(add_kdebase_dep kdepimlibs) )
	lcms? ( media-libs/lcms:2 )
	marble? ( $(add_kdebase_dep marble) )
	mysql? ( virtual/mysql )
	nepomuk? ( dev-libs/soprano )
	okular? ( $(add_kdebase_dep okular) )
	opengl? ( virtual/glu )
	opengtl? ( >=media-libs/opengtl-0.9.15 )
	openexr? ( media-libs/openexr )
	pdf? (
		app-text/poppler:=
		media-gfx/pstoedit
	)
	postgres? (
		dev-db/postgresql-base
		dev-libs/libpqxx
	)
	spacenav? ( dev-libs/libspnav  )
	ssl? ( dev-libs/openssl )
	sybase? ( dev-db/freetds )
	tiff? ( media-libs/tiff )
	truetype? ( media-libs/freetype:2 )
	vc? ( dev-libs/vc )
	xbase? ( dev-db/xbase )
	xslt? ( dev-libs/libxslt )
	calligra_features_kexi? (
		>=dev-db/sqlite-3.7.9:3[extensions(+)]
		dev-libs/icu:=
	)
"
DEPEND="${RDEPEND}"

[[ ${PV} == 9999 ]] && LANGVERSION="2.4" || LANGVERSION="$(get_version_component_range 1-2)"
PDEPEND=">=app-office/calligra-l10n-${LANGVERSION}"

RESTRICT=test
# bug 394273

pkg_pretend() {
	check-reqs_pkg_pretend
}

pkg_setup() {
	kde4-base_pkg_setup
	check-reqs_pkg_setup
}

src_configure() {
	local cal_ft

	# first write out things we want to hard-enable
	local mycmakeargs=(
		"-DIHAVEPATCHEDQT=ON"
		"-DWITH_Boost=ON"
		"-DWITH_LibXml2=ON"
		"-DWITH_PNG=ON"
		"-DWITH_ZLIB=ON"
		"-DGHNS=ON"
		"-DWITH_X11=ON"
		"-DWITH_Qt4=ON"
		"-DBUILD_libmsooxml=ON"      # only internal code, no deps
		"-DWITH_Iconv=ON"            # available on all supported arches and many more
	)

	# default disablers
	mycmakeargs+=(
		"-DBUILD_mobile=OFF"         # we dont support mobile gui, maybe arm could
		"-DBUILD_active=OFF"         # we dont support active gui, maybe arm could
		"-DWITH_LCMS=OFF"            # we use lcms:2
		"-DCREATIVEONLY=OFF"
		"-DPACKAGERS_BUILD=OFF"
		"-DWITH_TINY=OFF"
		"-DWITH_CreateResources=OFF" # NOT PACKAGED: http://create.freedesktop.org/
		"-DWITH_DCMTK=OFF"           # NOT PACKAGED: http://www.dcmtk.org/dcmtk.php.en
		"-DQT3SUPPORT=OFF"			 # Qt5 is on the way!
	)

	# regular options
	mycmakeargs+=(
		$(cmake-utils_use_with attica LibAttica)
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
		$(cmake-utils_use_with import-filter LibEtonyek)
		$(cmake-utils_use_with import-filter LibOdfGen)
		$(cmake-utils_use_with import-filter LibVisio)
		$(cmake-utils_use_with import-filter LibWpd)
		$(cmake-utils_use_with import-filter LibWpg)
		$(cmake-utils_use_with import-filter LibWps)
		$(cmake-utils_use_with jpeg JPEG)
		$(cmake-utils_use_with jpeg2k OpenJPEG)
		$(cmake-utils_use_with kdcraw Kdcraw)
		$(cmake-utils_use_with kde KActivities)
		$(cmake-utils_use_with kdepim KdepimLibs)
		$(cmake-utils_use_with lcms LCMS2)
		$(cmake-utils_use_with marble Marble)
		$(cmake-utils_use_with mysql MySQL)
		$(cmake-utils_use_build mysql mySQL)
		$(cmake-utils_use_with nepomuk Soprano)
		$(cmake-utils_use_with okular Okular)
		$(cmake-utils_use_with opengtl OpenCTL)
		$(cmake-utils_use_with openexr OpenEXR)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with pdf Poppler)
		$(cmake-utils_use_with pdf Pstoedit)
		$(cmake-utils_use_with postgres PostgreSQL)
		$(cmake-utils_use_build postgres pqxx)
		$(cmake-utils_use_with spacenav Spnav)
		$(cmake-utils_use_with ssl OpenSSL)
		$(cmake-utils_use_with sybase FreeTDS)
		$(cmake-utils_use_build sybase sybase)
		$(cmake-utils_use_with tiff TIFF)
		$(cmake-utils_use_with threads Threads)
		$(cmake-utils_use_with truetype Freetype)
		$(cmake-utils_use_with vc Vc)
		$(cmake-utils_use_with xbase XBase)
		$(cmake-utils_use_build xbase xbase)
		$(cmake-utils_use_with xslt LibXslt)
	)

	# applications
	for cal_ft in ${CAL_FTS}; do
		mycmakeargs+=( $(cmake-utils_use_build calligra_features_${cal_ft} ${cal_ft}) )
	done
	mycmakeargs+=( $(cmake-utils_use_build test cstester) )

	# filters

	kde4-base_src_configure
}
