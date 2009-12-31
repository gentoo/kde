# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils subversion

DESCRIPTION="PolicyKit Qt4 API wrapper library."
HOMEPAGE="http://kde.org/"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/polkit-qt"

LICENSE="LGPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug examples"

COMMON_DEPEND="
	>=sys-auth/policykit-0.8
	>=x11-libs/qt-gui-4.4:4[dbus]
"
DEPEND="${COMMON_DEPEND}
	kde-base/automoc
"
RDEPEND="${COMMON_DEPEND}
	examples? ( !sys-auth/polkit-qt[examples] )
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build examples)
	)

	cmake-utils_src_configure
}
