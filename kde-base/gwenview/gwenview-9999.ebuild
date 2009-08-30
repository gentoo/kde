# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="KDE image viewer"
KEYWORDS=""
IUSE="debug +handbook kipi +semantic-desktop"

# tests hang, last checked for 4.2.96
RESTRICT="test"

DEPEND="
	>=media-gfx/exiv2-0.18
	media-libs/jpeg
	kipi? ( >=kde-base/libkipi-${PV}:${SLOT}[kdeprefix=] )
	>=kde-base/kdelibs-${PV}:${SLOT}[kdeprefix=,semantic-desktop?]
"
RDEPEND="${DEPEND}
	semantic-desktop? ( >=kde-base/nepomuk-${PV}:${SLOT}[kdeprefix=] )
"

src_prepare() {
	kde4-meta_src_prepare

	# Remove compile-time dep on LibKNotificationItem
	sed -i -e '/LibKNotificationItem-1/s/^/#DONOTNEED /' CMakeLists.txt
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with kipi)"

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
