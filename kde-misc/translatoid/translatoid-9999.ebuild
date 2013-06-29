# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="playground/base/plasma/applets"
KDE_SCM="svn"
inherit kde4-base

DESCRIPTION="Translator plasmoid using google translator"
HOMEPAGE="http://kde-look.org/content/show.php/translatoid?content=97511"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS=""
IUSE="debug"

DEPEND="
	dev-libs/qjson
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep plasma-workspace)
"

S="${WORKDIR}/${PN}"
