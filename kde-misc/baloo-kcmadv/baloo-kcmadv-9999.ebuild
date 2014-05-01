# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Alternative configuration module for the Baloo search framework"
HOMEPAGE="https://gitorious.org/baloo-kcmadv"
EGIT_REPO_URI="git://gitorious.org/baloo-kcmadv/baloo-kcmadv.git"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE=""

DEPEND="
	dev-libs/qjson
	kde-base/kfilemetadata
	dev-libs/xapian
"
RDEPEND="${DEPEND}"
