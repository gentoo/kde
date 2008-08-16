# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdegraphics
inherit kde4-meta

DESCRIPTION="KDE image viewer"
KEYWORDS="~amd64"
IUSE="debug htmlhandbook kipi +semantic-desktop"

DEPEND="
	media-gfx/exiv2
	media-libs/jpeg
	kipi? ( kde-base/libkipi:${SLOT} )
	semantic-desktop? ( kde-base/nepomuk:${SLOT} )"

RDEPEND="${DEPEND}"

# Needed to find the slotted libkipi
PKG_CONFIG_PATH="${PKG_CONFIG_PATH}${PKG_CONFIG_PATH:+:}${KDEDIR}/$(get_libdir)/pkgconfig"
#[[ -z ${PKG_CONFIG_PATH} ]] && PKG_CONFIG_PATH="${KDEDIR}/$(get_libdir)/pkgconfig"
#[[ -z ${PKG_CONFIG_PATH} ]] || PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:${KDEDIR}/$(get_libdir)/pkgconfig"

# Tests are broken (4.1.0)
RESTRICT="test"

src_compile() {
	# testing PKG_CONFIG_PATH value
	echo "pkg_config: ${PKG_CONFIG_PATH}"

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with kipi KIPI)"
	if use semantic-desktop; then
		mycmakeargs="${mycmakeargs}
			-DGWENVIEW_METADATA_BACKEND=Nepomuk"
	else
		mycmakeargs="${mycmakeargs}
			-DGWENVIEW_METADATA_BACKEND=None"
	fi

	kde4-meta_src_compile
}

pkg_postinst() {
	kde4-meta_pkg_postinst
	echo
	elog "If you want to have svg support, emerge kde-base/svgpart"
	echo
}
