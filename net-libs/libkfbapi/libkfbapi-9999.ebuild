# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Library for accessing Facebook services based on KDE technology"
HOMEPAGE="https://projects.kde.org/projects/extragear/libs/libkfbapi"

LICENSE="|| ( LGPL-2 LGPL-3 )"
SLOT="4"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	dev-libs/libxslt
	dev-libs/qjson
"
RDEPEND="${DEPEND}"
