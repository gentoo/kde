# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_REQUIRED="never"
inherit git kde4-base

DESCRIPTION="Various utility programs for Amarok."
HOMEPAGE="http://amarok.kde.org/"
MY_PN="amarok"
S="${WORKDIR}/${MY_PN}"
EGIT_REPO_URI="git://gitorious.org/${MY_PN}/${MY_PN}.git"
EGIT_PROJECT="${MY_PN}"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	>=media-libs/taglib-1.5
	>=media-libs/taglib-extras-0.1
	>=x11-libs/qt-core-4.4:4
	>=x11-libs/qt-dbus-4.4:4
"
RDEPEND="${DEPEND}
	!<media-sound/amarok-2.0.90:${SLOT}
"

src_unpack() {
	git_src_unpack
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_PLAYER=OFF
		-DWITH_UTILITIES=ON"

	kde4-base_src_configure
}
