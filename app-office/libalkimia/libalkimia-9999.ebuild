# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="forceoptional"
KMNAME="alkimia"
inherit kde5

if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="mirror://kde/stable/${KMNAME}/${PV}/${KMNAME}-${PV}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Library with common classes and functionality used by KDE finance applications"
HOMEPAGE="https://www.linux-apps.com/content/show.php/libalkimia?content=137323"
LICENSE="LGPL-2.1"
SLOT="0/8"
IUSE="doc gmp plasma"

BDEPEND="
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
"
DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtwidgets)
	>=dev-qt/qtwebkit-5.212.0_pre20180120:5
	!gmp? ( sci-libs/mpir:=[cxx] )
	gmp? ( dev-libs/gmp:0=[cxx] )
	plasma? (
		$(add_frameworks_dep kpackage)
		$(add_frameworks_dep plasma)
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_DOXYGEN_DOCS=$(usex doc)
		$(cmake-utils_use_find_package !gmp MPIR)
		-DBUILD_APPLETS=$(usex plasma)
	)
	kde5_src_configure
}
