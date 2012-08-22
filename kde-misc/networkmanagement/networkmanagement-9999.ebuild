# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_MINIMAL="4.6"
KDE_LINGUAS="ar ast bs ca ca@valencia cs da de el en_GB eo es et fi fr ga gl hr
hu is it ja km ko lt lv mai ms nb nds nl nn pa pl pt pt_BR ro ru sk sl sq sv th
tr ug uk wa zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="KDE frontend for NetworkManager"
HOMEPAGE="http://kde.org/"
[[ ${PV} = 9999* ]] || SRC_URI="mirror://kde/unstable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	kde-misc/libmm-qt
	kde-misc/libnm-qt
	net-misc/mobile-broadband-provider-info
	>=net-misc/networkmanager-0.9.0
"
RDEPEND="${DEPEND}"

src_install() {
	kde4-base_src_install

	# drop some icons that collies with solid-4.7.1
	for x in 22 32 64; do
		rm "${ED}/usr/share/icons/oxygen/${x}x${x}/apps/networkmanager.png"
	done
}
