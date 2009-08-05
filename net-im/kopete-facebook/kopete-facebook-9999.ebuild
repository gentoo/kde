# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git kde4-base

DESCRIPTION="Facebook Chat support for Kopete"
HOMEPAGE="http://duncan.mac-vicar.com/blog/archives/tag/facebook"
EGIT_REPO_URI="git://github.com/dmacvicar/kopete-facebook.git"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	dev-libs/qjson
	>=kde-base/kopete-${KDE_MINIMAL}
"
RDEPEND="${DEPEND}
	!net-im/kopete-facebook:0
"

PATCHES=(
	"${FILESDIR}/${PN}-as-needed.patch"
)

src_unpack() {
	git_src_unpack
}
