# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/akonadi-server/akonadi-server-1.1.2.ebuild,v 1.1 2009/04/30 20:30:21 patrick Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="The server part of Akonadi"
HOMEPAGE="http://pim.kde.org/akonadi"
SRC_URI="http://download.akonadi-project.org/${P/-server/}.tar.bz2"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
SLOT="0"
IUSE="+mysql sqlite"

RDEPEND="
	dev-libs/boost
	>=dev-libs/soprano-2.2
	>=x11-libs/qt-core-4.5.0:4
	>=x11-libs/qt-dbus-4.5.0:4
	>=x11-libs/qt-sql-4.5.0:4[mysql?,sqlite?]
	x11-misc/shared-mime-info
"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	>=kde-base/automoc-0.9.88
"

S="${WORKDIR}/${P/-server/}"

src_install() {
	# Set default storage backend in order: mysql, sqlite
	if use mysql; then
		driver="QMYSQL"
	elif use sqlite; then
		driver="QSQLITE"
	fi
	# Who knows, maybe it accidentally fixes our permission issues
	mkdir -p "${D}"/usr/share/config/akonadi || die "mkdir failed"
	cat <<-EOF > "${D}"/usr/share/config/akonadi/akonadiserverrc
[%General]
Driver=${driver}
EOF

	cmake-utils_src_install
}

pkg_postinst() {
	if use mysql || use sqlite; then
		echo
		elog "${driver} has been set as your default akonadi storage backend."
		elog "You can override it in your ~/.config/akonadi/akonadiserverrc."
		elog "Available drivers are:"
		elog "QMYSQL, QSQLITE (experimental)"
		elog "Note that QMYSQL is the one fully tested and officially supported."
		echo
	else
		echo
		ewarn "You have decided to build akonadi-server with both"
		ewarn "'mysql' and 'sqlite' USE flags disabled."
		ewarn "akonadi-server will not be functional."
		echo
	fi
}
