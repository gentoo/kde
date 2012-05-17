# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit kde4-base

DESCRIPTION="A krunner plug-in that translates words using google."
HOMEPAGE="http://kde-apps.org/content/show.php/krunner-googletranslate?content=144348"
SRC_URI="http://gt.kani.hu/distfiles/krunner/${P}.tbz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	$( add_kdebase_dep libkworkspace)
	$( add_kdebase_dep krunner)
	"

RDEPEND="${DEPEND}"

DOCS="README"

S="${WORKDIR}/${PN}"
