# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
KDE_LINGUAS="de es nl pl"
KDE_LINGUAS_LIVE_OVERRIDE="true"

inherit kde4-base

DESCRIPTION="KControl module for xf86-input-synaptics"
HOMEPAGE="http://kde-apps.org/content/show.php/kcm_touchpad?content=113335"
EGIT_REPO_URI="git://github.com/mishaaq/kcm_touchpad.git"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	x11-libs/libXi
"
DEPEND="${RDEPEND}
	>=x11-proto/inputproto-2.0
"

DOCS=( AUTHORS README )

src_prepare() {
	sed -e "/^install( FILES AUTHORS/d" -i CMakeLists.txt || die
	kde4-base_src_prepare
}
