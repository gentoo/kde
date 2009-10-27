# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="bg ca cs da de el en_GB es et fi fr ga gl hu it lt ms nb nds nl nn
pl pt pt_BR ro ru sk sv sr tr uk zh_CN zh_TW"

KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"

inherit kde4-base

MY_P="${P/_}"

DESCRIPTION="A collection manager for the KDE environment."
HOMEPAGE="http://www.periapsis.org/tellico/"
SRC_URI="http://tellico-project.org/files/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="4"
IUSE="addressbook cddb debug +handbook pdf scanner taglib xmp yaz"

DEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
	x11-libs/qt-dbus:4
	addressbook? ( >=kde-base/kdepimlibs-${KDE_MINIMAL} )
	cddb? ( >=kde-base/libkcddb-${KDE_MINIMAL} )
	pdf? ( virtual/poppler-qt4 )
	scanner? ( >=kde-base/libksane-${KDE_MINIMAL} )
	taglib? ( >=media-libs/taglib-1.5 )
	xmp? ( >=media-libs/exempi-2 )
	yaz? ( >=dev-libs/yaz-2 )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	# Kcal marked as failing to build in CMakeLists.txt by upstream
	local mycmakeargs="${mycmakeargs}
		-DWITH_Kcal=OFF
		$(cmake-utils_use_with addressbook Kabc)
		$(cmake-utils_use_with cddb Kcddb)
		$(cmake-utils_use_with pdf PopplerQt4)
		$(cmake-utils_use_with scanner KSane)
		$(cmake-utils_use_with taglib)
		$(cmake-utils_use_with xmp Exempi)
		$(cmake-utils_use_with yaz)
	"

	kde4-base_src_configure
}
