# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

#KDE_LINGUAS="bg ca da de en_GB es et fr gl it lt ms nds nl pl pt pt_BR ro sk sv
#tr uk zh_CN"
#KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"
KMNAME="extragear/office"
inherit kde4-base

DESCRIPTION="personal finances manager for KDE4, aiming at being simple and intuitive"
HOMEPAGE="http://www.kde-apps.org/content/show.php/skrooge?content=92458"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug test"

DEPEND="
	app-crypt/qca:2
	dev-libs/libofx
	x11-libs/qt-sql[sqlite]
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use test SKG_BUILD_TEST)
	)
	kde4-base_src_configure
}
