# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

if [[ ${PV} != *9999* ]]; then
	KDE_LINGUAS="bg bs ca ca@valencia cs da de el en_GB eo es et fa fi fr ga gl
	hr hu is ja km lt ms nb nds nl pa pl pt pt_BR ro ru sk sq sv tr ug uk zh_CN
	zh_TW"
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
	KDE_HANDBOOK="optional"
	KEYWORDS="~amd64 ~x86"
else
	KDE_SCM="git"
	KEYWORDS=""
fi

inherit kde4-base

DESCRIPTION="Free/Open Source micro-blogging client for KDE"
HOMEPAGE="http://choqok.gnufolks.org/"

LICENSE="GPL-3"
SLOT="4"
IUSE="debug indicate"

DEPEND="dev-libs/qjson
	>=dev-libs/qoauth-1.0.1
	indicate? ( dev-libs/libindicate-qt )
"
RDEPEND="${DEPEND}"

src_prepare(){
	mycmakeargs=(
		$(cmake-utils_use !indicate QTINDICATE_DISABLE)
	)

	kde4-base_src_prepare
}
