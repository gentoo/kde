# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/kipi-plugins/kipi-plugins-1.7.0.ebuild,v 1.2 2011/01/09 13:43:39 dilfridge Exp $

EAPI=3

OPENGL_REQUIRED="optional"
if [ "${PV}" != "9999" ]; then
	KDE_LINGUAS="ar ast be ca ca@valencia cs da de el en_GB eo es et eu fi fr ga gl hi hne hr is it ja km
		lt lv mai ms nb nds nl nn pa pl pt pt_BR ro ru se sv tr uk zh_CN zh_TW"
else
	KMNAME="extragear/graphics"
fi
KDE_MINIMAL="4.5"
inherit flag-o-matic kde4-base

DESCRIPTION="Plugins for the KDE Image Plugin Interface"
HOMEPAGE="http://www.kipi-plugins.org"
[[ ${PV} != *9999* ]] && SRC_URI="mirror://sourceforge/kipi/${P}.tar.bz2
	handbook? ( mirror://gentoo/${PN}-doc-1.5.0.tar.bz2 )"

LICENSE="GPL-2
	handbook? ( FDL-1.2 )"
KEYWORDS=""
SLOT="4"
IUSE="cdr calendar crypt debug expoblending handbook +imagemagick ipod mjpeg redeyes scanner"

DEPEND="
	>=dev-libs/expat-2.0.1
	>=dev-libs/libxml2-2.7
	>=dev-libs/libxslt-1.1
	dev-libs/qjson
	$(add_kdebase_dep libkdcraw)
	$(add_kdebase_dep libkexiv2)
	$(add_kdebase_dep libkipi)
	virtual/jpeg
	media-libs/libpng
	media-libs/tiff
	calendar?	( $(add_kdebase_dep kdepimlibs) )
	crypt?		( app-crypt/qca:2 )
	ipod?		(
			  media-libs/libgpod
			  x11-libs/gtk+:2
			)
	redeyes?	( media-libs/opencv )
	scanner? 	(
			  $(add_kdebase_dep libksane)
			  media-gfx/sane-backends
			)
"
RDEPEND="${DEPEND}
	cdr? 		( app-cdr/k3b )
	expoblending? 	( media-gfx/hugin )
	imagemagick? 	( || ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] ) )
	mjpeg? 		( media-video/mjpegtools )
"

PATCHES=( "${FILESDIR}/${PN}-1.7.0-expoblending.patch" )

src_prepare() {
	if use handbook; then
		mv "${WORKDIR}/${PN}"-1.5.0/* "${S}/" || die
		echo "add_subdirectory( doc )" >> CMakeLists.txt
	else
		mkdir doc || die
		echo >> doc/CMakeLists.txt || die
	fi

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
		$(cmake-utils_use_with redeyes OpenCV)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with crypt QCA2)
		$(cmake-utils_use_with scanner Sane)
		$(cmake-utils_use_enable expoblending)
	)

	kde4-base_src_configure
}

src_install() {
	kde4-base_src_install

	if use handbook; then
		dodoc readme-handbook.txt || die
	fi
}
