# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/gwenview/gwenview-4.2.1-r1.ebuild,v 1.1 2009/03/06 01:16:28 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="KDE image viewer"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug kipi +semantic-desktop"
RESTRICT="test"

DEPEND="
	media-gfx/exiv2
	media-libs/jpeg
	kipi? ( >=kde-base/libkipi-${PV}:${SLOT} )
	>=kde-base/kdelibs-${PV}:${SLOT}[semantic-desktop?]
"

RDEPEND="${DEPEND}"

PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:${KDEDIR}/$(get_libdir)/pkgconfig"

# Patch sent to the packagers ml to fix the version.
PATCHES=( "${FILESDIR}/${PN}-fix-version.diff" )

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with kipi Kipi)"

	if use semantic-desktop; then
		mycmakeargs="${mycmakeargs}
			-DGWENVIEW_SEMANTICINFO_BACKEND=Nepomuk"
	else
		mycmakeargs="${mycmakeargs}
			-DGWENVIEW_SEMANTICINFO_BACKEND=None"
	fi

	kde4-meta_src_configure
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	echo
	elog "If you want to have svg support, emerge kde-base/svgpart"
	echo
}
