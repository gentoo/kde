# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/akonadi-server/akonadi-server-1.1.2.ebuild,v 1.1 2009/04/30 20:30:21 patrick Exp $

EAPI="2"

inherit qt4 cmake-utils

DESCRIPTION="The server part of Akonadi"
HOMEPAGE="http://pim.kde.org/akonadi"
SRC_URI="http://download.akonadi-project.org/${P/-server/}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
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

S="${WORKDIR}/${P/-server/}"

src_prepare() {
	# Don't check for mysql, avoid an automagic dep.
	if ! use mysql; then
		sed -e '/mysqld/s/find_program/#DONOTWANT &/' \
			-i "${S}"/server/CMakeLists.txt || die 'Sed failed.'
	fi
}

pkg_postinst() {
	if ! use mysql; then
		echo
		ewarn "You have decided to build akonadi-server with mysql USE"
		ewarn "flag disabled. Note, that this is the only supported"
		ewarn "database backend, hence akonadi-server will not work."
		echo
	fi
}
