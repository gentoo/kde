# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
KDE_LINGUAS="bg bs ca ca@valencia cs da de el en_GB eo es et eu fi fr ga gl
hu it ja kk lt ms nds nl pl pt pt_BR ro ru sk sv tr ug uk zh_CN zh_TW"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"
KDE_HANDBOOK="optional"
CPPUNIT_REQUIRED="test"
VIRTUALX_REQUIRED="test"
VIRTUALDBUS_TEST="true"
inherit kde4-base

DESCRIPTION="Personal finance manager for KDE"
HOMEPAGE="http://kmymoney2.sourceforge.net/"
if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="mirror://sourceforge/kmymoney2/${P}.tar.bz2"
fi

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug calendar doc hbci ofx quotes"

COMMON_DEPEND="
	app-crypt/gpgme
	>=app-office/libalkimia-4.3.2
	dev-cpp/glibmm:2
	dev-cpp/libxmlpp:2.6
	dev-libs/boost:=
	dev-libs/glib:2
	dev-libs/gmp
	dev-libs/libgpg-error
	dev-libs/libxml2
	$(add_kdebase_dep kdepimlibs)
	x11-misc/shared-mime-info
	calendar? ( dev-libs/libical )
	hbci? (
		>=net-libs/aqbanking-5.0.1
		>=sys-libs/gwenhywfar-4.0.1[qt4]
	)
	ofx? ( >=dev-libs/libofx-0.9.4 )
"
RDEPEND="${COMMON_DEPEND}
	quotes? ( dev-perl/Finance-Quote )
"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
"

src_configure() {
	mycmakeargs=(
		-DUSE_QT_DESIGNER=OFF
		$(cmake-utils_use_enable calendar LIBICAL)
		$(cmake-utils_use_use doc DEVELOPER_DOC)
		$(cmake-utils_use_enable hbci KBANKING)
		$(cmake-utils_use_enable ofx LIBOFX)
	)
	kde4-base_src_configure
}

src_compile() {
	kde4-base_src_compile

	use doc && kde4-base_src_compile apidoc
}

src_install() {
	use doc && HTML_DOCS=("${CMAKE_BUILD_DIR}/apidocs/html/")
	kde4-base_src_install
}
