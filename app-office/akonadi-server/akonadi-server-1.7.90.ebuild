# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/akonadi-server/akonadi-server-1.7.2.ebuild,v 1.5 2012/06/07 21:22:12 ranger Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="The server part of Akonadi"
HOMEPAGE="http://pim.kde.org/akonadi"
SRC_URI="mirror://kde/stable/${PN/-server/}/src/${P/-server/}.tar.bz2"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
SLOT="0"
IUSE="mysql postgres +sqlite test"

CDEPEND="
	dev-libs/boost
	>=dev-libs/soprano-2.6.51
	>=x11-libs/qt-gui-4.5.0:4[dbus]
	>=x11-libs/qt-sql-4.5.0:4[mysql?,postgres?]
	>=x11-libs/qt-test-4.5.0:4
	x11-misc/shared-mime-info
"
DEPEND="${CDEPEND}
	dev-libs/libxslt
	>=dev-util/automoc-0.9.88
"
RDEPEND="${CDEPEND}
	postgres? ( dev-db/postgresql-server )
"

REQUIRED_USE="|| ( sqlite mysql postgres )"

S=${WORKDIR}/${P/-server/}

RESTRICT=test
# bug 401139

pkg_setup() {
	# Set default storage backend in order: SQLite, MySQL, PostgreSQL
	# reverse driver check to keep the order
	if use postgres; then
		DRIVER="QPSQL"
		AVAILABLE+=" ${DRIVER}"
	fi

	if use mysql; then
		DRIVER="QMYSQL"
		AVAILABLE+=" ${DRIVER}"
	fi

	if use sqlite; then
		DRIVER="QSQLITE3"
		AVAILABLE+=" ${DRIVER}"
	fi

	# Notify about driver name change
	if use sqlite && has_version "<=${CATEGORY}/${PN}-1.4.0[sqlite]"; then
		ewarn
		ewarn "SQLite driver name changed from QSQLITE to QSQLITE3."
		ewarn "Please edit your ~/.config/akonadi/akonadiserverrc."
	fi

	# Notify about MySQL not being default anymore
	if ! use mysql && has_version "<=${CATEGORY}/${PN}-1.4.0[mysql]"; then
		ewarn
		ewarn "MySQL driver is not enabled by default in Gentoo anymore."
		ewarn "If you intend to use it, please enable mysql USE flag and reinstall"
		ewarn "${CATEGORY}/${PN}."
		ewarn "Otherwise select different driver in your ~/.config/akonadi/akonadiserverrc."
		ewarn "Available drivers are:${AVAILABLE}"
	fi
}

src_configure() {
	local mycmakeargs=(
		-DAKONADI_USE_STRIGI_SEARCH=OFF
		$(cmake-utils_use test AKONADI_BUILD_TESTS)
		$(cmake-utils_use sqlite AKONADI_BUILD_QSQLITE)
	)

	cmake-utils_src_configure
}

src_install() {
	# Who knows, maybe it accidentally fixes our permission issues
	cat <<-EOF > "${T}"/akonadiserverrc
[%General]
Driver=${DRIVER}
EOF
	insinto /usr/share/config/akonadi
	doins "${T}"/akonadiserverrc

	cmake-utils_src_install
}

pkg_postinst() {
	echo
	elog "${DRIVER} has been set as your default akonadi storage backend."
	elog "You can override it in your ~/.config/akonadi/akonadiserverrc."
	elog "Available drivers are: ${AVAILABLE}"
}
