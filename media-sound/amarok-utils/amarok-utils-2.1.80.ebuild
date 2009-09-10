# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amarok-utils/amarok-utils-2.1.1.ebuild,v 1.1 2009/06/26 11:05:41 tampakrap Exp $

EAPI="2"

EGIT_REPO_URI="git://gitorious.org/${MY_PN}/${MY_PN}.git"
EGIT_PROJECT="${MY_PN}"

[[ ${PV} = *9999* ]] && git="git" || git=""

KMNAME="extragear/multimedia"
KMMODULE="amarok"
KDE_REQUIRED="never"
inherit ${git} kde4-base

DESCRIPTION="Various utility programs for Amarok."
HOMEPAGE="http://amarok.kde.org/"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://kde/unstable/${PN/-utils/}/${PV}/src/${P/-utils/}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	SRC_URI=""
	KEYWORDS=""
fi

LICENSE="GPL-2"
SLOT="4"
IUSE="debug"

DEPEND="
	>=media-libs/taglib-1.5
	>=media-libs/taglib-extras-0.1
	>=x11-libs/qt-core-4.4:4
	>=x11-libs/qt-dbus-4.4:4
"
RDEPEND="${DEPEND}
	!<media-sound/amarok-2.1.80:2
	!<media-sound/amarok-2.1.80:${SLOT}
"

S="${WORKDIR}/${P/-utils/}"

src_unpack() {
	if [[ ${PV} = *9999* ]]; then
		git_src_unpack
	else
		kde4-base_src_unpack
	fi
}

src_prepare() {
	# Disable po processing
	sed -e "s:include(MacroOptionalAddSubdirectory)::" \
		-i "${S}/CMakeLists.txt" \
		|| die "Removing include of MacroOptionalAddSubdirectory failed."
	sed -e "s:macro_optional_add_subdirectory( po )::" \
		-i "${S}/CMakeLists.txt" \
		|| die "Removing include of MacroOptionalAddSubdirectory failed."

	kde4-base_src_prepare
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_PLAYER=OFF
		-DWITH_UTILITIES=ON"

	kde4-base_src_configure
}
