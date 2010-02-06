# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="playground/office"
inherit kde4-base

DESCRIPTION="kmymoney is a personal finance program for KDE4"
HOMEPAGE="http://techbase.kde.org/Projects/KMyMoney"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug hbci ical ofx quotes test"

COMMONDEPEND="
	app-crypt/gpgme
	>=dev-libs/boost-1.33.1
	dev-libs/libxml2
	dev-libs/libgpg-error
	>=kde-base/kdepimlibs-${KDE_MINIMAL}
	hbci? (
		>=net-libs/aqbanking-4.2.4[qt4]
		>=sys-libs/gwenhywfar-3.10
	)
	ical? ( dev-libs/libical )
	ofx? ( >=dev-libs/libofx-0.9 )
"
RDEPEND="${COMMONDEPEND}
	quotes? ( dev-perl/Finance-Quote )"
DEPEND="${COMMONDEPEND}
	test? ( >=dev-util/cppunit-1.12 )"

src_prepare() {
	kde4-base_src_prepare

	# Fix multilib and RPATH
	sed -e '/SET(CMAKE_INSTALL_RPATH/s/^/# DISABLED /g' \
		-i CMakeLists.txt || die "failed to disable setting bad RPATH"
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable hbci KBANKING)
		$(cmake-utils_use_enable ical LIBICAL)
		$(cmake-utils_use_enable ofx LIBOFX)
		$(cmake-utils_use test KDE4_BUILD_TESTS)
	)
	kde4-base_src_configure
}
