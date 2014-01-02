# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Translator plasmoid using google translator"
HOMEPAGE="http://kde-look.org/content/show.php/translatoid?content=97511"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="+remember debug"

if (use remember); then
	SRC_URI="http://212.158.157.7/translatoid/${P}.tar.xz"
else
	SRC_URI="http://212.158.157.7/translatoid/${P}-noremember.tar.xz"
fi

DEPEND="
	dev-libs/qjson
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep plasma-workspace)
"

S="${WORKDIR}/${PN}"
