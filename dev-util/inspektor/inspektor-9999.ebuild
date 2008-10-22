# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME="playground/sysadmin"
NEED_KDE="svn"

inherit kde4svn

DESCRIPTION="Inspektor is a KDE interface for strace."
HOMEPAGE="http://www.kde.org"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="kde-svn"
IUSE=""

DEPEND="kde-base/ksysguard:${SLOT}"
RDEPEND="dev-util/strace"

src_unpack() {
	subversion_src_unpack

	sed -i '3 i FIND_PACKAGE(KDE4 REQUIRED)\n' CMakeLists.txt
}
