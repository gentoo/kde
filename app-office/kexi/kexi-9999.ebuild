# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="koffice"
inherit kde4-meta

DESCRIPTION="KOffice integrated environment for database management."
KEYWORDS=""
IUSE="freetds htmlhandbook mysql postgres xbase"

DEPEND="
	sys-libs/readline
	app-arch/bzip2
	freetds? ( dev-db/freetds )
	mysql? ( virtual/mysql )
	postgres? ( =dev-libs/libpqxx-2.6* )
	xbase? ( dev-db/xbase )
"
RDEPEND="${DEPEND}"

KMLOADLIBS="koffice-libs"
KMEXTRACTONLY="libs/"

src_configure() {
	 mycmakeargs="${mycmakeargs}
		-DWITH_WEBFORMS=Off
		$(cmake-utils_use_with freetds FreeTDS)
		$(cmake-utils_use_with mysql MySQL)
		$(cmake-utils_use_with postgres PostgreSQL)
		$(cmake-utils_use_with postgres Pqxx)
		$(cmake-utils_use_with xbase XBase)"

	kde4-meta_src_configure
}
