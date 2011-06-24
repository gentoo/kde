# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
EGIT_REPONAME="akonadi-googledata-resource"
inherit kde4-base

DESCRIPTION="Google contacts and calendar akonadi resource"
HOMEPAGE="http://pim.kde.org/akonadi/"
LICENSE="GPL-2"

SLOT="4"
IUSE="debug"

DEPEND="
	dev-libs/boost
	dev-libs/libxslt
	$(add_kdebase_dep kdepimlibs semantic-desktop)
	>=net-libs/libgcal-0.9.6
"
RDEPEND="${DEPEND}
	!kde-misc/googledata
"

src_configure() {
	local mycmakeargs=(-DLIBGCAL_INCLUDE_DIR="${EPREFIX}"/usr/include/libgcal)
	kde4-base_src_configure
}
