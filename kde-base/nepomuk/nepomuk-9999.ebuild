# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="Nepomuk KDE4 client"
KEYWORDS=""
IUSE="debug"

DEPEND="
	dev-libs/soprano[clucene]
	>=kde-base/kdelibs-${PV}:${SLOT}[semantic-desktop]
"
RDEPEND="${DEPEND}"

src_prepare() {
	# Make redland really optional
	sed -i -e 's/ AND SOPRANO_PLUGIN_RAPTORPARSER_FOUND//g' \
		CMakeLists.txt || die "Failed to make redlang parser optional"

	kde4-meta_src_prepare
}
