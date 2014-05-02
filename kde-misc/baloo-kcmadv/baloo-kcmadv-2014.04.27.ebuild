# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Alternative configuration module for the Baloo search framework"
HOMEPAGE="https://gitorious.org/baloo-kcmadv"
EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}"
SRC_URI="http://dev.gentoo.org/~dilfridge/distfiles/${P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE=""

DEPEND="
	$(add_kdebase_dep kfilemetadata)
	dev-libs/qjson
	dev-libs/xapian
"
RDEPEND="${DEPEND}"
