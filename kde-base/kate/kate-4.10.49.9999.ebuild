# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
PYTHON_DEPEND="pate? 2"
inherit python kde4-base

DESCRIPTION="Kate is an MDI texteditor."
KEYWORDS=""
IUSE="debug pate +plasma"

DEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
	pate? ( $(add_kdebase_dep pykde4 '' 4.9.2-r1) )
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep katepart)
"

pkg_setup() {
	if use pate; then
		python_set_active_version 2
		python_pkg_setup
	fi
	kde4-base_pkg_setup
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build pate)
		$(cmake-utils_use_with plasma)
	)

	kde4-base_src_configure
}

pkg_postinst() {
	kde4-base_pkg_postinst

	if ! has_version kde-base/kaddressbook:${SLOT}; then
		echo
		elog "File templates plugin requires kde-base/kaddressbook:${SLOT}."
		elog "Please install it if you plan to use this plugin."
		echo
	fi
}
