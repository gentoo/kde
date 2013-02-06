# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

if [[ $PV = *9999* ]]; then
	scm_eclass=git-2
	EGIT_REPO_URI="git://anongit.kde.org/akonadi"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="mirror://kde/stable/${PN/-server/}/src/${P/-server/}.tar.bz2"
	KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
	S="${WORKDIR}/${P/-server/}"
fi

inherit cmake-utils ${scm_eclass}

DESCRIPTION="The server part of Akonadi"
HOMEPAGE="http://pim.kde.org/akonadi"

LICENSE="LGPL-2.1"
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

RESTRICT=test

PATCHES=( "${FILESDIR}/${P}-qt5.patch" )

pkg_setup() {
	# Set default storage backend in order: MySQL, SQLite PostgreSQL
	# reverse driver check to keep the order
	if use postgres; then
		DRIVER="QPSQL"
		AVAILABLE+=" ${DRIVER}"
	fi

	if use sqlite; then
		DRIVER="QSQLITE3"
		AVAILABLE+=" ${DRIVER}"
	fi

	if use mysql; then
		DRIVER="QMYSQL"
		AVAILABLE+=" ${DRIVER}"
	fi

	# Notify about driver name change
	if use sqlite && has_version "<=${CATEGORY}/${PN}-1.4.0[sqlite]"; then
		ewarn
		ewarn "SQLite driver name changed from QSQLITE to QSQLITE3."
		ewarn "Please edit your ~/.config/akonadi/akonadiserverrc."
	fi

	# Notify about MySQL not being default anymore
	if ! use sqlite && has_version "<=${CATEGORY}/${PN}-1.4.0[sqlite]"; then
		ewarn
		ewarn "The default storage drive has changed from SQLite to MySQL."
		ewarn "If you want to stay with SQLite, enable the sqlite USE flag and reinstall"
		ewarn "${CATEGORY}/${PN}."
		ewarn "Otherwise, select a different driver in your ~/.config/akonadi/akonadiserverrc."
		ewarn "Available drivers are:${AVAILABLE}"
	fi
}

src_configure() {
	local mycmakeargs=(
		-DAKONADI_USE_STRIGI_SEARCH=OFF
		-DWITH_QT5=OFF
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
