# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

MY_P="${P/qt/qt-1}"

inherit cmake-utils

DESCRIPTION="PolicyKit Qt4 API wrapper library."
HOMEPAGE="http://kde.org/"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug examples"

COMMON_DEPEND="
	dev-libs/glib:2
	>=sys-auth/polkit-0.99
	x11-libs/qt-core
	x11-libs/qt-gui[dbus]
"
DEPEND="${COMMON_DEPEND}
	dev-util/automoc
"
RDEPEND="${COMMON_DEPEND}
	examples? ( !sys-auth/policykit-qt[examples] )
"

DOCS=(AUTHORS README README.porting TODO)

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build examples)
	)
	cmake-utils_src_configure
}
