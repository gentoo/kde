# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit ecm kde.org

DESCRIPTION="Input method frontend for Plasma"
HOMEPAGE="https://www.linux-apps.com/content/show.php?content=140967"

if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="https://dl.opendesktop.org/api/files/download/id/1466629206/140967-${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2+"
SLOT="5"
IUSE="libressl scim semantic-desktop"

DEPEND="
	app-i18n/ibus
	dev-libs/glib:2
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	kde-frameworks/karchive:5
	kde-frameworks/kconfig:5
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/kdbusaddons:5
	kde-frameworks/ki18n:5
	kde-frameworks/kiconthemes:5
	kde-frameworks/kio:5
	kde-frameworks/knewstuff:5
	kde-frameworks/knotifications:5
	kde-frameworks/kwidgetsaddons:5
	kde-frameworks/kwindowsystem:5
	kde-frameworks/kxmlgui:5
	kde-frameworks/plasma:5
	media-libs/libpng:0=[apng]
	x11-libs/libX11
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:= )
	scim? (
		>=app-i18n/scim-1.4.9
		dev-libs/dbus-c++
	)
	semantic-desktop? ( kde-frameworks/kfilemetadata:5 )
"
RDEPEND="${DEPEND}
	>=app-i18n/fcitx-4.0
"

src_prepare() {
	ecm_src_prepare

	# bug 581736
	cmake_comment_add_subdirectory po
}

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package scim SCIM)
		$(cmake_use_find_package scim DBusCXX)
		$(cmake_use_find_package semantic-desktop KF5FileMetaData)
	)

	ecm_src_configure
}
