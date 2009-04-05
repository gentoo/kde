# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit qt4 cmake-utils subversion

DESCRIPTION="The server part of Akonadi"
HOMEPAGE="http://pim.kde.org/akonadi"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/akonadi"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="+mysql"

RDEPEND="x11-libs/qt-core:4
	x11-libs/qt-dbus:4
	x11-libs/qt-sql:4[mysql?]
	x11-misc/shared-mime-info"
DEPEND="${RDEPEND}
	dev-libs/boost
	dev-libs/libxslt
	>=dev-libs/soprano-2.2
	>=kde-base/automoc-0.9.88
"

src_prepare() {
	# Don't check for mysql, avoid an automagic dep.
	if ! use mysql; then
		sed -e '/mysqld/s/find_program/#DONOTWANT &/' \
			-i "${S}"/server/CMakeLists.txt || die 'Sed failed.'
	fi
}
