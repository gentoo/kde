# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils subversion

DESCRIPTION="The server part of Akonadi"
HOMEPAGE="http://pim.kde.org/akonadi"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/akonadi"

LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="0"
IUSE="+mysql"

RDEPEND="
	dev-libs/boost
	>=dev-libs/soprano-2.2
	>=x11-libs/qt-core-4.5.0:4
	>=x11-libs/qt-dbus-4.5.0:4
	>=x11-libs/qt-sql-4.5.0:4[mysql?]
	x11-misc/shared-mime-info
"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	>=kde-base/automoc-0.9.88
"

pkg_postinst() {
	if ! use mysql; then
		echo
		ewarn "You have decided to build akonadi-server with mysql USE"
		ewarn "flag disabled. Note, that this is the only supported"
		ewarn "database backend, hence akonadi-server will not work."
		echo
	fi
}
