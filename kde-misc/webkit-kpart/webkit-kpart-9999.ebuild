# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

HOMEPAGE="http://www.kde.org"
KMNAME="playground/libs/webkitkde"
KMMODULE="webkitkde"
NEED_KDE="svn"
SLOT="kde-svn"
inherit kde4svn-meta

# Install to KDEDIR rather than /usr, allows slotting
PREFIX="${KDEDIR}"

DESCRIPTION="A WebKit KPart for konqueror"
LICENSE="GPL-2"
KEYWORDS=""
IUSE="debug"

DEPEND="x11-libs/qt-webkit:4"
RDEPEND="${RDEPEND}
	kde-base/konqueror:${SLOT}"

src_unpack() {
	kde4svn_src_unpack

	# CMakeLists bugs.
	#sed -e '/CMAKE_MODULE_PATH/s/^/#DONOTWANT /' \
	#	-e '/add_subdirectory(cmake)/s/^/#DONOTWANT /' \
	#	-i "${S}"/CMakeLists.txt || die 'Sed failed.'
}
