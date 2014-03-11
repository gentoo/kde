# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS="ar bs ca ca@valencia cs da de el en_GB eo es et fa fi fr ga gl hr
hu is it ja km lt lv mai mr ms nb nds nl nn pa pl pt pt_BR ro ru sk sl sr
sr@ijekavian sr@ijekavianlatin sr@latin sv th tr ug uk zh_CN zh_TW"
DECLARATIVE_REQUIRED="always"
inherit kde4-base

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	KEYWORDS="~amd64 ~x86"
	SRC_URI="mirror://kde/unstable/${PN}/${P}.tar.xz"
else
	KEYWORDS=""
fi

DESCRIPTION="KDE Plasma applet for NetworkManager"
HOMEPAGE="https://projects.kde.org/projects/playground/network/plasma-nm"

LICENSE="GPL-2 LGPL-2.1"
SLOT="4"
IUSE="debug modemmanager"

DEPEND="
	>=net-libs/libnm-qt-0.9.8.0[modemmanager?]
	>=net-misc/networkmanager-0.9.8.0
	modemmanager? ( >=net-libs/libmm-qt-1.0.0 )
"
RDEPEND="${DEPEND}
	!kde-misc/networkmanagement
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use !modemmanager DISABLE_MODEMMANAGER_SUPPORT)
	)

	kde4-base_src_configure
}
