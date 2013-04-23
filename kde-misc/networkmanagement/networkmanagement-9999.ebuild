# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS="ar ca cs da de el es et fa fi fr ga hu it ja kk km lt nb nds nl nn pl
pt pt_BR se sk sr sr@ijekavian sr@ijekavianlatin sr@latin sv tr uk zh_TW"
inherit kde4-base

DESCRIPTION="KDE frontend for NetworkManager"
HOMEPAGE="http://kde.org/"
[[ ${PV} = 9999* ]] || SRC_URI="mirror://kde/unstable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug openconnect"

DEPEND="
	net-libs/libmm-qt
	kde-misc/libnm-qt
	net-misc/mobile-broadband-provider-info
	>=net-misc/networkmanager-0.9.0
	openconnect? ( net-misc/openconnect )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with openconnect)
	)
	kde4-base_src_configure
}
