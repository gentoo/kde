# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS="bg bs ca ca@valencia cs da de el en_GB es et fi fr gl he hu it ja
kk km lt nb nds nl pl pt pt_BR ru si sk sl sr sr@ijekavian sr@ijekavianlatin
sr@latin sv tr uk zh_CN zh_TW"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"
KDE_HANDBOOK="optional"
inherit kde4-base

MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="A user friendly IRC Client for KDE4"
HOMEPAGE="http://konversation.kde.org"
SRC_URI="mirror://kde/unstable/${PN}/${MY_PV}/src/${MY_P}.tar.xz"

LICENSE="GPL-2 FDL-1.2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="+crypt debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	crypt? ( app-crypt/qca:2 )
"
RDEPEND="${DEPEND}
	crypt? ( app-crypt/qca-ossl )
"

DOCS="AUTHORS ChangeLog NEWS README TODO"

S="${WORKDIR}/${MY_P}"

src_configure() {
	mycmakeargs+=(
		$(cmake-utils_use_with crypt QCA2)
	)
	kde4-base_src_configure
}
