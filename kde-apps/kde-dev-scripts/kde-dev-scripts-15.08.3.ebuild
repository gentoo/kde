# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE Development Scripts"
KEYWORDS=" ~amd64 ~x86"
IUSE="debug"

RDEPEND="
	app-arch/advancecomp
	media-gfx/optipng
	dev-perl/XML-DOM
"

src_prepare() {
	# bug 275069
	sed -ie 's:colorsvn::' CMakeLists.txt || die

	kde4-base_src_prepare
}
