# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS="bg bs ca ca@valencia cs da de el en_GB eo es et fi fr ga gl hu ia
it ja ko lt mr ms nb nds nl pl pt pt_BR ro ru sk sv tr ug uk zh_CN zh_TW"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="personal finances manager for KDE4, aiming at being simple and intuitive"
HOMEPAGE="http://www.skrooge.org/"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	app-crypt/qca:2
	dev-db/sqlite:3
	dev-libs/grantlee:0
	>=dev-libs/libofx-0.9.1
	dev-libs/qjson
	dev-qt/qtsql:4[sqlite]
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kde-dev-scripts)
"

# upstream does not ship tests in releases
if [[ ${KDE_BUILD_TYPE} != live ]]; then
	RESTRICT="test"
fi

DOCS=( AUTHORS CHANGELOG README TODO )

src_test() {
	local mycmakeargs=(
		-DSKG_BUILD_TEST=ON
	)
	kde4-base_src_test
}
