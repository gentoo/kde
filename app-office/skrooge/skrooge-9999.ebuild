# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_LINGUAS="bg bs ca ca@valencia cs da de el en_GB eo es et fr ga gl hu it ja
ko lt ms nb nds nl pl pt pt_BR ro ru sk sv tr ug uk zh_CN zh_TW"
KDE_DOC_DIRS="doc"
KDE_HANDBOOK=optional
inherit kde4-base

DESCRIPTION="personal finances manager for KDE4, aiming at being simple and intuitive"
HOMEPAGE="http://www.skrooge.org/"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS=""
IUSE="debug"

DEPEND="
	app-crypt/qca:2
	dev-libs/grantlee
	>=dev-libs/libofx-0.9.1
	dev-qt/qtsql:4[sqlite]
"
RDEPEND="${DEPEND}
	|| (
		( $(add_kdebase_dep kde-dev-scripts) )
		( $(add_kdebase_dep kdesdk-scripts) )
	)
"

DOCS=( AUTHORS CHANGELOG README TODO )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use test SKG_BUILD_TEST)
	)
	kde4-base_src_configure
}
