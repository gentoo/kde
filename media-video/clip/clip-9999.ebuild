# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_QTHELP="true"
KDE_ORG_CATEGORY="maui"
KFMIN=5.82.0
QTMIN=5.15.5
inherit ecm kde.org

DESCRIPTION=""

LICENSE="LGPL-3"
SLOT="5"
KEYWORDS=""
IUSE="mpv"

DEPEND="
	media-libs/taglib:=
	media-video/ffmpeg:=
	>=dev-libs/mauikit-${KFMIN}:5
	>=dev-libs/mauikit-filebrowsing-${KFMIN}:5
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtmultimedia-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/kdbusaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	mpv? ( media-video/mpv[libmpv] )
	!mpv? ( >=dev-qt/qtmultimedia-${QTMIN}:5[gstreamer] )
"
RDEPEND="${DEPEND}
	media-plugins/gst-plugins-meta
"
PATCHES=( "${FILESDIR}"/${PN}-9999-libmpv-new-api.patch )

src_configure() {
	local mycmakeargs=(
		-DMPV_AVAILABLE=$(usex mpv)
	)
	cmake_src_configure
}
