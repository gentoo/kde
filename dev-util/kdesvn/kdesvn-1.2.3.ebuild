# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_MINIMAL="4.1"
KDE_LINGUAS="cs de es fr ja lt nl ru"
inherit kde4-base flag-o-matic

DESCRIPTION="KDESvn is a frontend to the subversion vcs."
HOMEPAGE="http://www.alwins-world.de/wiki/programs/kdesvn"
SRC_URI="http://kdesvn.alwins-world.de/downloads/${P}.tar.bz2"

SLOT="1.2"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="dev-db/sqlite
	>=dev-util/subversion-1.4
	kde-base/kdesdk-kioslaves"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6"

src_configure() {
	append-cppflags -DQT_THREAD_SUPPORT
	mycmakeargs="${mycmakeargs}
		-DLIB_INSTALL_DIR=${KDEDIR}/$(get_libdir)"

	kde4-base_src_configure
}

src_install() {
	kde4-base_src_install

	rm "${D}"/${KDEDIR}/share/kde4/services/svn.protocol
	rm "${D}"/${KDEDIR}/share/kde4/services/svn+ssh.protocol
	rm "${D}"/${KDEDIR}/share/kde4/services/svn+https.protocol
	rm "${D}"/${KDEDIR}/share/kde4/services/svn+file.protocol
	rm "${D}"/${KDEDIR}/share/kde4/services/svn+http.protocol
}

pkg_postinst() {
	if ! has_version 'kde-base/kompare'; then
		elog
		elog "For nice graphical diffs, install kde-base/kompare."
		elog
	fi

	kde4-base_pkg_postinst
}
