# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2_pre1"

NEED_KDE="4.1"
inherit kde4-base

DESCRIPTION="A digital photo management application for KDE."
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/${PN}/${P/_/-}.tar.bz2"

LICENSE="GPL-2"
RDEPEND="${DEPEND}"
SLOT="4.1"
IUSE="debug"

LANGS="ar be bg ca da de el es et eu fa fi fr ga gl he hi is ja km ko lt lv lb
nds ne nl nn pa pl pt pt_BR ro ru se sk sv th tr uk vi zh_CN"
for LANG in ${LANGS}; do
	IUSE="${IUSE} linguas_${LANG}"
done

S="${WORKDIR}/${P/_/-}"

KEYWORDS="~amd64"

# it have dynamic search for deps, so if they are in system it
# uses them otherwise does not, so any iuse are useless
DEPEND="
	dev-db/sqlite:3
	kde-base/libkdcraw:${SLOT}
	kde-base/libkexiv2:${SLOT}
	kde-base/libkipi:${SLOT}
	kde-base/marble:${SLOT}
	kde-base/solid:${SLOT}
	>=media-libs/jasper-1.701.0
	media-libs/jpeg
	>=media-libs/lcms-1.17
	>=media-libs/libgphoto2-2.4.1-r1
	>=media-libs/libpng-1.2.26-r1
	>=media-libs/tiff-3.8.2-r3
	sys-devel/gettext
	x11-libs/qt-core[qt3support]
	x11-libs/qt-sql[sqlite]
	!kdeprefix? ( !media-gfx/digikam:0 )"
#liblensfun when added should be also dep.
RDEPEND="${DEPEND}"

# fixes search for correct deps.
PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:${KDEDIR}/$(get_libdir)/pkgconfig"

# we want to install into kdedir so we can keep kde3 and kde4 version along
PREFIX="${KDEDIR}"
pkg_setup() {
	if ! built_with_use kde-base/marble:${SLOT} kde; then
		eerror "kdebase/marlbe must be build with USE kde."
		eerror "Please reemerge marble with kde useflag."
		die
	fi
}
src_unpack() {
	local lang

	unpack ${A}
	cd "${S}"
	# take care of linguas
	comment_all_add_subdirectory po/ || die "sed to remove all linguas failed."
	for LANG in ${LINGUAS}; do
		sed -i \
			-e "/add_subdirectory(\s*${LANG}\s*)\s*$/s/^#DONOTCOMPILE //" \
			po/CMakeLists.txt || die "Sed to uncomment ${LANG} failed."
	done
}
