# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils subversion

DESCRIPTION="libtelepathy QT4 Bindings"
HOMEPAGE="http://telepathy.freedesktop.org/wiki/TelepathyQt"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/telepathy-qt"

KEYWORDS=""
SLOT="0"
LICENSE="LGPL-2.1"
IUSE="debug"

RDEPEND="|| ( ( x11-libs/qt-core:4
		x11-libs/qt-dbus:4 )
	>=x11-libs/qt-4.2.0 )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6.0"

pkg_setup() {
	echo
	ewarn "WARNING! This an experimental ebuild of ${PN} SVN tree. Use at your own risk."
	ewarn "Do _NOT_ file bugs at bugs.gentoo.org because of this ebuild!"
	echo
}
