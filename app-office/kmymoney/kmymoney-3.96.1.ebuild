# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KDE_LINGUAS="bg ca ca@valencia cs da de el en_GB eo es et fi fr ga gl it lt ms
nds nl pl pt pt_BR ro ru sk sv tr uk zh_CN zh_TW"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"
inherit virtualx kde4-base

DESCRIPTION="A personal finance manager for KDE"
HOMEPAGE="http://sourceforge.net/projects/kmymoney2/"
SRC_URI="mirror://sourceforge/kmymoney2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug calendar +handbook hbci ofx quotes test"

COMMON_DEPEND="app-crypt/gpgme
	>=dev-libs/boost-1.33.1
	dev-libs/libxml2
	dev-libs/libgpg-error
	>=kde-base/kdepimlibs-${KDE_MINIMAL}
	calendar? ( dev-libs/libical )
	hbci? ( >=net-libs/aqbanking-4.2.4[qt4]
		>=sys-libs/gwenhywfar-3.11.3 )
	ofx? ( >=dev-libs/libofx-0.9.1 )"
RDEPEND="${COMMON_DEPEND}
	quotes? ( dev-perl/Finance-Quote )"
DEPEND="${COMMON_DEPEND}
	test? ( >=dev-util/cppunit-1.12.1 )"

DOCS="AUTHORS BUGS ChangeLog* README* TODO"

src_configure() {
	mycmakeargs+=(
		$(cmake-utils_use_enable hbci KBANKING)
		$(cmake-utils_use_enable calendar LIBICAL)
		$(cmake-utils_use_enable ofx LIBOFX)
		$(cmake-utils_use test KDE4_BUILD_TESTS)
		)

	kde4-base_src_configure
}

src_test() {
	export maketype="kde4-base_src_test"
	virtualmake
}
