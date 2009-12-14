# Copyright 1999-2009 Gentoo Foundation
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
IUSE="debug hbci ical ofx"

COMMONDEPEND="
	app-crypt/gpgme
	>=dev-libs/boost-1.33.1
	dev-libs/libxml2:2
	>=kde-base/kdepimlibs-${KDE_MINIMAL}
	>=kde-base/libkleo-${KDE_MINIMAL}
	media-libs/jpeg
	media-libs/libpng
	sys-libs/zlib
	hbci? (
		>=net-libs/aqbanking-4.2.0[qt4]
		>=sys-libs/gwenhywfar-3.10.0.0
	)
	ical? ( dev-libs/libical )
	ofx? ( >=dev-libs/libofx-0.8.2 )
"
DEPEND="${COMMONDEPEND}"
RDEPEND="${COMMONDEPEND}"

src_prepare() {
	kde4-base_src_prepare

	epatch "${FILESDIR}/cmake-optional.patch"
	# Fix multilib and RPATH
	sed -e '/SET(CMAKE_INSTALL_RPATH/s/^/# DISABLED /g' \
		-i CMakeLists.txt || die "failed to disable setting bad RPATH"
}

src_configure() {
	mycmakeargs=(
		-DUSE_QT_DESIGNER=ON
		$(cmake-utils_use_enable hbci AQBANKING)
		$(cmake-utils_use_enable ical)
		$(cmake-utils_use_enable ofx)
	)
	kde4-base_src_configure
}
