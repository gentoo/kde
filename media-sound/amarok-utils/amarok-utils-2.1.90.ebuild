# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

if [[ ${PV} = *9999* ]]; then
	GIT_ECLASS="git"
	EGIT_PROJECT="amarok"
	EGIT_REPO_URI="git://gitorious.org/amarok/amarok.git"
fi

inherit base cmake-utils ${GIT_ECLASS}

MY_PN="amarok"

DESCRIPTION="Various utility programs for Amarok."
HOMEPAGE="http://amarok.kde.org/"
if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
else
	SRC_URI="mirror://kde/unstable/${MY_PN}/${PV}/src/${MY_PN}-${PV}.tar.bz2"
fi

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	>=media-libs/taglib-1.6
	>=media-libs/taglib-extras-1.0.0
	>=x11-libs/qt-core-4.4:4
	>=x11-libs/qt-dbus-4.4:4
"
RDEPEND="${DEPEND}
	!<media-sound/amarok-2.1.80:2
	!<media-sound/amarok-2.1.80:${SLOT}
"

S="${WORKDIR}/${MY_PN}-${PV}"

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
