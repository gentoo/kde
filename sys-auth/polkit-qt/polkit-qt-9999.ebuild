# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit subversion cmake-utils

DESCRIPTION="PolicyKit Qt4 API wrapper library."
HOMEPAGE="http://kde.org/"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/polkit-qt-1"

LICENSE="LGPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug doc examples"

RDEPEND="
	>=sys-auth/polkit-0.95
	x11-libs/qt-gui[dbus]
"
DEPEND="${RDEPEND}
	kde-base/automoc
	doc? ( app-doc/doxygen )
"

DOCS="AUTHORS README README.porting TODO"

src_unpack() {
	subversion_src_unpack
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build examples)
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile

	if use doc; then
		doxygen Doxyfile || die "doxygen failed"
	fi
}

src_install() {
	cmake-utils_src_install

	if use doc; then
		dohtml -r "${S}/html/" || die "dohtml failed"
	fi
}
