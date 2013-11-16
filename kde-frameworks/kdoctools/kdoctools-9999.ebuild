# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_TYPE="tier2"
FRAMEWORKS_DOXYGEN="true"
inherit kde-frameworks

DESCRIPTION="Documentation tools library"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep karchive)
	app-text/docbook-xml-dtd
	app-text/docbook-xsl-stylesheets
	dev-libs/libxml2:2
	dev-libs/libxslt
"
DEPEND="${RDEPEND}"
