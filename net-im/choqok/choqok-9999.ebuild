# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS="bg bs ca ca@valencia cs da de el en_GB eo es et fa fi fr ga gl
hr hu is it ja km lt mr ms nb nds nl pa pl pt pt_BR ro ru sk sq sl sv tr ug
uk zh_CN zh_TW"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="Free/Open Source micro-blogging client for KDE"
HOMEPAGE="http://choqok.gnufolks.org/"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"
	KEYWORDS="amd64 ~ppc x86"
else
	KEYWORDS=""
fi

LICENSE="GPL-2+"
SLOT="4"
IUSE="ayatana debug"

RDEPEND="
	dev-libs/libattica
	dev-libs/qjson
	>=dev-libs/qoauth-1.0.1
	ayatana? ( dev-libs/libindicate-qt )
"
DEPEND="${RDEPEND}
	app-arch/xz-utils
"

src_prepare(){
	local mycmakeargs=(
		$(cmake-utils_use !ayatana QTINDICATE_DISABLE)
	)

	kde4-base_src_prepare
}
