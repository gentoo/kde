# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="Framework for working with KDE activities"
LICENSE="LGPL-2+"
KEYWORDS=" ~amd64"
IUSE=""

RDEPEND="
	$(add_frameworks_dep kdbusaddons)
	dev-qt/qtdbus:5
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DKACTIVITIES_LIBRARY_ONLY=true
	)

	kde5_src_configure
}
