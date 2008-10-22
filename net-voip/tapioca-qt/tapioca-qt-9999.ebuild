# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit cmake-utils subversion

DESCRIPTION="Tapioca QT4 Bindings"
HOMEPAGE="http://tapioca-voip.sourceforge.net/wiki/index.php/Tapioca"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/tapioca-qt"

KEYWORDS=""
SLOT="0"
LICENSE="LGPL-2.1"
IUSE="debug"

DEPEND="|| ( ( x11-libs/qt-core:4
		x11-libs/qt-dbus:4 )
	>=x11-libs/qt-4.2:4 )
	net-libs/telepathy-qt"

pkg_setup() {
	echo
	ewarn "WARNING! This an experimental ebuild of ${PN} SVN tree. Use at your own risk."
	ewarn "Do _NOT_ file bugs at bugs.gentoo.org because of this ebuild!"
	echo
}
