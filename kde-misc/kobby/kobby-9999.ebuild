# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base git

DESCRIPTION="collaborative Editor for KDE"
HOMEPAGE="http://wiki.github.com/greghaynes/kobby"
EGIT_REPO_URI="git://gitorious.org/kobby/mainline.git"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

DEPEND="
	net-libs/libqinfinity
"
RDEPEND="${DEPEND}"

# Needed since git eclass provides one..
src_prepare() {
	kde4-base_src_prepare
}
