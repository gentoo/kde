# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

DESCRIPTION="Translator plasmoid using google translator"
HOMEPAGE="http://kde-look.org/content/show.php/translatoid?content=97511"
SRC_URI="http://212.158.157.7/translatoid/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	dev-libs/qjson
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep plasma-workspace)
"

S="${WORKDIR}/${PN}"
