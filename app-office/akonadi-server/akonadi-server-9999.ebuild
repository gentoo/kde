# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ $PV = *9999* ]]; then
	EGIT_REPONAME="${PN/-server/}"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="mirror://kde/stable/${PN/-server/}/src/${P/-server/}.tar.bz2"
	KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
	S="${WORKDIR}/${P/-server/}"
fi

KDE_TESTS=true
VIRTUALDBUS_TEST=true
inherit kde5

DESCRIPTION="The server part of Akonadi"
HOMEPAGE="http://pim.kde.org/akonadi"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="+mysql postgres sqlite test"

REQUIRED_USE="|| ( sqlite mysql postgres )"

CDEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsql:5[mysql?,postgres?]
	dev-qt/qttest:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	x11-misc/shared-mime-info
	sqlite? ( dev-db/sqlite:3 )
"
DEPEND="${CDEPEND}
	dev-libs/libxslt
	test? ( sys-apps/dbus )
"
RDEPEND="${CDEPEND}
	postgres? ( dev-db/postgresql )
"

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

	# Notify about MySQL is recommend by upstream
	if use sqlite || has_version "<${CATEGORY}/${P}[sqlite]"; then
		ewarn
		ewarn "We strongly recommend you change your Akonadi database backend to MySQL in your"
		ewarn "user configuration. This is the backend recommended by KDE upstream."
		ewarn "In particular, kde-base/kmail-4.10 does not work properly with the sqlite"
		ewarn "backend anymore."
		ewarn "You can select the backend in your ~/.config/akonadi/akonadiserverrc."
		ewarn "Available drivers are:${AVAILABLE}"
		ewarn
	fi
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_ASAN=ON
		-DINSTALL_QSQLITE_IN_QT_PREFIX=ON
		$(cmake-utils_use sqlite AKONADI_BUILD_QSQLITE)
	)

	kde5_src_configure
}

src_install() {
	# Who knows, maybe it accidentally fixes our permission issues
	cat <<-EOF > "${T}"/akonadiserverrc
[%General]
Driver=${DRIVER}
EOF
	insinto /usr/share/config/akonadi
	doins "${T}"/akonadiserverrc

	kde5_src_install
}

pkg_postinst() {
	elog "${DRIVER} has been set as your default akonadi storage backend."
	elog "You can override it in your ~/.config/akonadi/akonadiserverrc."
	elog "Available drivers are: ${AVAILABLE}"
}
