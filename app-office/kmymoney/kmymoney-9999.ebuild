# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="playground/office"
inherit kde4-base

DESCRIPTION="kmymoney is a personal finance program for KDE4"
HOMEPAGE="http://techbase.kde.org/Projects/KMyMoney"

KEYWORDS=""
LICENSE="GPL-2"
SLOT="4"
IUSE="debug hbci ical ofx"

COMMONDEPEND="app-crypt/gpgme
		sys-libs/gwenhywfar
		kde-base/kdepimlibs
		dev-libs/libxml2
		kde-base/libkleo
		x11-misc/shared-mime-info
		hbci? ( >=net-libs/aqbanking-4.2.0[qt4] )
		ical? ( dev-libs/libical )
		ofx? ( >=dev-libs/libofx-0.8.2 )"

DEPEND="${COMMONDEPEND}"

RDEPEND="${COMMONDEPEND}"

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
