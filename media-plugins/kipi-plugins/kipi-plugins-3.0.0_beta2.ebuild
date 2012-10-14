# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/kipi-plugins/kipi-plugins-2.9.0.ebuild,v 1.1 2012/09/03 19:13:18 creffett Exp $

EAPI=4

OPENGL_REQUIRED="optional"

KDE_MINIMAL="4.7"

KDE_LINGUAS="ar az be bg bn br bs ca cs csb cy da de el en_GB eo es et eu fa fi fo fr fy ga
gl ha he hi hr hsb hu id is it ja ka kk km ko ku lb lo lt lv mi mk mn ms mt nb nds ne nl nn
nso oc pa pl pt pt_BR ro ru rw se sk sl sq sr ss sv ta te tg th tr tt uk uz ven vi wa xh
zh_CN zh_HK zh_TW zu"

KDE_HANDBOOK="optional"

inherit flag-o-matic kde4-base

MY_PV=${PV/_/-}
MY_P="digikam-${MY_PV}"

DESCRIPTION="Plugins for the KDE Image Plugin Interface"
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://kde/unstable/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2
	handbook? ( FDL-1.2 )"
KEYWORDS=""
SLOT="4"
IUSE="cdr calendar crypt debug expoblending gpssync +imagemagick ipod mediawiki mjpeg panorama redeyes scanner vkontakte"

DEPEND="
	$(add_kdebase_dep libkipi '' '4.9.80')
	$(add_kdebase_dep libkdcraw '' '4.9.80')
	$(add_kdebase_dep libkexiv2)
	dev-libs/expat
	dev-libs/libxml2
	dev-libs/libxslt
	dev-libs/qjson
	gpssync?	( media-libs/libkgeomap )
	media-libs/libpng
	media-libs/tiff
	virtual/jpeg
	calendar?	( $(add_kdebase_dep kdepimlibs) )
	crypt?		( app-crypt/qca:2 )
	ipod?		(
			  media-libs/libgpod
			  x11-libs/gtk+:2
			)
	mediawiki?	( >=media-libs/libmediawiki-2.6.0 )
	panorama?	( dev-libs/boost )
	redeyes?	( media-libs/opencv )
	scanner? 	(
			  $(add_kdebase_dep libksane)
			  media-gfx/sane-backends
			)
	vkontakte?	( net-libs/libkvkontakte )
"
RDEPEND="${DEPEND}
	cdr? 		( app-cdr/k3b )
	expoblending? 	( media-gfx/hugin )
	imagemagick? 	( || ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] ) )
	mjpeg? 		( media-video/mjpegtools )
	panorama?	(
			  media-gfx/enblend
			  >=media-gfx/hugin-2011.0.0
			)
"

S=${WORKDIR}/${MY_P}/extra/${PN}

RESTRICT=test
# bug 420203

PATCHES=(
	"${FILESDIR}/${PN}-2.6.0_beta3-options.patch"
)

src_prepare() {
	# prepare the handbook
	mv "${WORKDIR}/${MY_P}/doc/${PN}" "${WORKDIR}/${MY_P}/extra/${PN}/doc" || die
	if use handbook; then
		echo "add_subdirectory( doc )" >> CMakeLists.txt
	fi

	# prepare the translations
	mv "${WORKDIR}/${MY_P}/po" po || die
	find po -name "*.po" -and -not -name "kipiplugin*.po" -exec rm {} +
	echo "find_package(Msgfmt REQUIRED)" >> CMakeLists.txt || die
	echo "find_package(Gettext REQUIRED)" >> CMakeLists.txt || die
	echo "add_subdirectory( po )" >> CMakeLists.txt

	kde4-base_src_prepare
}

src_configure() {
	# Remove flags -floop-block -floop-interchange
	# -floop-strip-mine due to bug #305443.
	filter-flags -floop-block
	filter-flags -floop-interchange
	filter-flags -floop-strip-mine

	mycmakeargs+=(
		$(cmake-utils_use_with ipod GLIB2)
		$(cmake-utils_use_with ipod GObject)
		$(cmake-utils_use_with ipod Gdk)
		$(cmake-utils_use_with ipod Gpod)
		$(cmake-utils_use_with calendar KdepimLibs)
		$(cmake-utils_use_with gpssync KGeoMap)
		$(cmake-utils_use_with mediawiki MEDIAWIKI)
		$(cmake-utils_use_with redeyes OpenCV)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with crypt QCA2)
		$(cmake-utils_use_with scanner KSane)
		$(cmake-utils_use_enable expoblending)
		$(cmake-utils_use_enable panorama)
	)

	kde4-base_src_configure
}
