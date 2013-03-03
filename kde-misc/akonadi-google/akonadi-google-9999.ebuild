# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

EGIT_REPO_URI="git://anongit.kde.org/scratch/dvratil/akonadi-google-resources"
DESCRIPTION="Google services integration in Akonadi"
HOMEPAGE="https://projects.kde.org/projects/scratch/dvratil/akonadi-google"
LICENSE="GPL-2"

SLOT="4"
KEYWORDS=""
IUSE="oldpim"

DEPEND="
	$(add_kdebase_dep kdepimlibs semantic-desktop)
	dev-libs/libxslt
	dev-libs/qjson
	net-libs/libkgapi
	oldpim? ( dev-libs/boost:= )
	!oldpim? ( $(add_kdebase_dep kdepimlibs semantic-desktop 4.6.0) )
	!>=kde-base/kdepim-runtime-4.8.50
"
RDEPEND=${DEPEND}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use oldpim KCAL)
	)
	kde4-base_src_configure
}
