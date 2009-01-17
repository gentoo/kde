# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

# Checkout all of extragear/graphics to avoid endless patching of the
# cmake files.
KMNAME="extragear/graphics"
NEED_KDE="svn"

inherit kde4svn-meta

DESCRIPTION="A digital photo management application for KDE."
HOMEPAGE="http://www.digikam.org/"

LICENSE="GPL-2"
SLOT="kde-svn"
RDEPEND="${DEPEND}"
IUSE="addressbook marble"

KEYWORDS=""
DEPEND="
	dev-db/sqlite:3
	kde-base/libkdcraw:${SLOT}
	kde-base/libkexiv2:${SLOT}
	kde-base/libkipi:${SLOT}
	>=media-libs/jasper-1.7.0
	media-libs/jpeg
	>=media-libs/lcms-1.14.0
	>=media-libs/libgphoto2-2.4.0
	>=media-libs/libpng-1.2.7
	>=media-libs/tiff-3.8.2
	addressbook? ( kde-base/kdepimlibs:${SLOT} )
	marble? ( kde-base/marble )
	"
# No ebuild?
# liblensfun      >= 0.1.0                        http://lensfun.berlios.de
# Optional to support LensCorrection editor plugin.
#WITH_Freetype                    ON
# Needed?
#	imlib? ( media-libs/imlib )

RDEPEND="${DEPEND}"

# Install to KDEDIR to slot it.
PREFIX="${KDEDIR}"
# Search for the dependencies in KDEDIR.
PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:${KDEDIR}/$(get_libdir)/pkgconfig"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with addressbook KdepimLibs)"
	# Deactivate the search for ksane
	sed -e '/KSANE/I s:^:#DONOTWANT :' \
		-i "${S}"/CMakeLists.txt \
		|| die "Deactivating ksane check failed."
	# Deactivate this, fails.
	sed -e '/lenscorrection/ s:^:#DONOTWANT :' \
		-i "${S}"/digikam/imageplugins/CMakeLists.txt \
		|| die "Deactivating lensfun plugin failed."

	kde4overlay-base_src_compile
}
