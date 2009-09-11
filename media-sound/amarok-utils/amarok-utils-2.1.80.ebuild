# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit base cmake-utils

MY_PN="amarok"

DESCRIPTION="Various utility programs for Amarok."
HOMEPAGE="http://amarok.kde.org/"
SRC_URI="mirror://kde/unstable/${MY_PN}/${PV}/src/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
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

S="${WORKDIR}/${MY_PN}-${PV}"

PATCHES=(
	"${FILESDIR}/${PN}-add-kdemacros.h.patch"
)

DOCS="TODO README ChangeLog AUTHORS"

src_prepare() {
	# Disable po processing
	sed -e "s:include(MacroOptionalAddSubdirectory)::" \
		-i "${S}/CMakeLists.txt" \
		|| die "Removing include of MacroOptionalAddSubdirectory failed."
	sed -e "s:macro_optional_add_subdirectory( po )::" \
		-i "${S}/CMakeLists.txt" \
		|| die "Removing include of MacroOptionalAddSubdirectory failed."

	base_src_prepare
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_PLAYER=OFF
		-DWITH_UTILITIES=ON"

	cmake-utils_src_configure
}
