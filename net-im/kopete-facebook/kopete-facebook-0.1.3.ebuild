# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils

MY_PN="dmacvicar-${PN}-ffc26f60c2d08260098eeb7bc22119a0dc35ccd3"

DESCRIPTION="Facebook Chat support for Kopete"
HOMEPAGE="http://duncan.mac-vicar.com/blog/archives/tag/facebook"
SRC_URI="http://download.github.com/${MY_PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/qjson"
RDEPEND=">=kde-base/kopete-4.2"

PATCHES=( "${FILESDIR}/${PN}-as-needed.patch" )

S="${WORKDIR}/${MY_PN}"

