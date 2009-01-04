# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils qt4

DESCRIPTION="The server part of Akonadi"
HOMEPAGE="http://pim.kde.org/akonadi"
SRC_URI="http://akonadi.omat.nl/${P/-server/}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+mysql"

RDEPEND="x11-libs/qt-core:4
	x11-libs/qt-dbus:4
	x11-libs/qt-sql:4[mysql?]
	x11-libs/qt-test:4
	x11-misc/shared-mime-info"
DEPEND="${RDEPEND}
	dev-libs/boost
	dev-libs/libxslt
	kde-base/automoc"

S="${WORKDIR}/${P/-server/}"

src_prepare() {
	# Don't check for mysql, avoid an automagic dep.
	if ! use mysql; then
		sed -e '/mysqld/s/find_program/#DONOTWANT &/' \
			-i "${S}"/server/CMakeLists.txt || die 'Sed failed.'
	fi
}
