# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_MINIMAL=4.13.0
inherit kde4-base

DESCRIPTION="Alternative configuration module for the Baloo search framework"
HOMEPAGE="https://gitorious.org/baloo-kcmadv"
EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE=""

DEPEND="
	$(add_kdebase_dep baloo)
	$(add_kdebase_dep kfilemetadata)
	dev-libs/qjson
	dev-libs/xapian
"
RDEPEND="${DEPEND}"
