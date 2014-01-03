# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kdesupport"
KDE_SCM="svn"
KDE_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="Unofficial taglib plugins maintained by the Amarok team"
HOMEPAGE="http://developer.kde.org/~wheeler/taglib.html"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

RDEPEND="
	>=media-libs/taglib-1.6
"
DEPEND="${RDEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with kde)
	)

	kde4-base_src_configure
}

pkg_postinst() {
	if [[ -d "${ESVN_STORE_DIR}/playground/multimedia/${PN}" ]]; then
		echo
		ewarn "taglib-extras has been moved from playground/multimedia to kdesupport."
		elog "You may now remove ${ESVN_STORE_DIR}/playground/multimedia/${PN}"
		echo
	fi
}
