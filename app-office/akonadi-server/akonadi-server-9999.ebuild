# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit subversion cmake-utils qt4

DESCRIPTION="The server part of Akonadi"
HOMEPAGE="http://www.kde.org"
SRC_URI=""
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/akonadi"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="mysql"

RDEPEND="!app-office/akonadi
	x11-libs/qt-core:4
	x11-libs/qt-dbus:4
	x11-libs/qt-sql:4
	x11-misc/shared-mime-info
	mysql? ( virtual/mysql )"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	kde-base/automoc"

QT_BUILT_WITH_USE_CHECK="dbus sqlite3"

src_unpack() {
	subversion_src_unpack

	# Don't check for mysql, avoid an automagic dep.
	if ! use mysql; then
		sed -e '/mysqld/s/find_program/#DONOTWANT &/' \
			-i "${S}"/server/CMakeLists.txt || die 'Sed failed.'
	fi
}
