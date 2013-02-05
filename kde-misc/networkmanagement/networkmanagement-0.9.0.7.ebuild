# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/networkmanagement/networkmanagement-0.9.0.6.ebuild,v 1.4 2013/01/27 16:16:11 ago Exp $

EAPI=5

KDE_LINGUAS="ar bs ca cs da de el es et fa fi fr ga gl hu it ja kk km lt mr nb nds nl nn pl
pt pt_BR ro ru se sk sl sr sr@ijekavian sr@ijekavianlatin sr@Latn sv tr uk zh_CN zh_TW"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE frontend for NetworkManager"
HOMEPAGE="http://www.kde.org/"
[[ ${PV} = 9999* ]] || SRC_URI="mirror://kde/unstable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug openconnect"

DEPEND="
	$(add_kdebase_dep solid)
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
