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
SLOT="0"
IUSE="debug hbci ical ofx"

COMMON_DEPEND="dev-libs/libxml2
		app-crypt/gpgme
		kde-base/kdepimlibs
		x11-misc/shared-mime-info"

DEPEND="${COMMON_DEPEND}
	hbci? ( >=net-libs/aqbanking-4.2.0[qt4] )
	ical? ( dev-libs/libical )
	ofx? ( >=dev-libs/libofx-0.8.2 )"

src_prepare() {
	epatch "${FILESDIR}/cmake-optional.patch"
}

src_configure() {
	mycmakeargs=(
	$(cmake-utils_use_enable hbci AQBANKING)
	$(cmake-utils_use_enable ical ICAL)
	$(cmake-utils_use_enable ofx OFX)
	)
	kde4-base_src_configure
}
