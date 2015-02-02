# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS="bg bs ca ca@valencia cs da de el en_GB es et fi fr gl he hu it ja
kk km ko lt nb nds nl pa pl pt pt_BR ru si sk sl sr sr@ijekavian
sr@ijekavianlatin sr@latin sv tr uk zh_CN zh_TW"
KDE_HANDBOOK="optional"
EGIT_BRANCH="1.5"
inherit kde4-base

DESCRIPTION="A user friendly IRC Client for KDE4"
HOMEPAGE="http://kde.org/applications/internet/konversation/ http://konversation.kde.org"

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
KEYWORDS=""
IUSE="+crypt debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	media-libs/phonon[qt4]
	crypt? ( app-crypt/qca:2[qt4] )
"
RDEPEND="${DEPEND}
	crypt? ( app-crypt/qca:2[openssl] )
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with crypt QCA2)
	)

	kde4-base_src_configure
}
