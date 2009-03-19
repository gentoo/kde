# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

# TODO add KMNAME=kdesupport handling in eclass
NEED_KDE="none"
inherit kde4-base

DESCRIPTION="Unofficial taglib plugins maintained by the Amarok team"
HOMEPAGE="http://developer.kde.org/~wheeler/taglib.html"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug kde"

RDEPEND="
	>=media-libs/taglib-1.5
	kde? ( >=kde-base/kdelibs-${KDE_MINIMAL} )
"
DEPEND="${RDEPEND}"

src_configure() {
	# if not using kde then remove kdeprefix flag
	use kde || PREFIX="/usr"

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with kde KDE)"

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
