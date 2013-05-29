# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

WEBKIT_REQUIRED="always"
KDE_LINGUAS="cs da de el es et fi fr hu ia it km lt mr nb nl pl pt pt_BR sk sl
sr sr@ijekavian sr@ijekavianlatin sr@latin sv tr uk zh_CN zh_TW"
KDE_HANDBOOK="optional"
KDE_MINIMAL="4.10"
inherit kde4-base

DESCRIPTION="A browser based on qtwebkit"
HOMEPAGE="http://rekonq.kde.org/"
[[ ${PV} != *9999* ]] && SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS=""
IUSE="debug kde opera"

DEPEND="
	kde? (
		$(add_kdebase_dep kactivities)
		$(add_kdebase_dep nepomuk-core)
		dev-libs/soprano
	)
	opera? (
		app-crypt/qca:2
		dev-libs/qoauth
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with kde KActivities)
		$(cmake-utils_use_find_package kde NepomukCore)
		$(cmake-utils_use_with opera QCA2)
		$(cmake-utils_use_with opera QtOAuth)
	)

	kde4-base_src_configure
}
