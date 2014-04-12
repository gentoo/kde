# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS="bs ca ca@valencia cs da de el es et fi fr ga gl hu ia it ja kk ko
lt mr nb nds nl pl pt pt_BR ro ru sk sl sr sr@ijekavian sr@ijekavianlatin
sr@latin sv uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="KDE Telepathy common library"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://kde/stable/kde-telepathy/${PV}/src/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="LGPL-2.1"
SLOT="4"
IUSE="debug semantic-desktop"

DEPEND="
	>=net-libs/telepathy-qt-0.9.3
	>=net-libs/telepathy-logger-qt-0.5.80
	semantic-desktop? (
		$(add_kdebase_dep kdepimlibs)
		>=net-libs/libkpeople-0.2.1
	)
"
RDEPEND="${DEPEND}
	!!<net-im/ktp-contact-list-0.4.0
	!<net-im/ktp-text-ui-0.5.80
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package semantic-desktop KPeople)
		$(cmake-utils_use_find_package semantic-desktop KdepimLibs)
	)

	kde4-base_src_configure
}
