# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils git

DESCRIPTION=""
HOMEPAGE="http://www.kde.org"
EGIT_REPO_URI="git://github.com/dmacvicar/kopete-facebook.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/qjson"
RDEPEND=">=kde-base/kopete-4.2"

PATCHES=( "${FILESDIR}/${PN}-as-needed.patch" )
