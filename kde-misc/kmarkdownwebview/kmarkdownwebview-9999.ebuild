# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit ecm kde.org

DESCRIPTION="KPart for rendering Markdown content"
HOMEPAGE="https://frinring.wordpress.com/2017/09/14/kmarkdownwebview-0-1-0/"

LICENSE="!webkit? ( BSD ) LGPL-2.1+"
SLOT="5"
KEYWORDS=""
IUSE="webkit"

DEPEND="
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/ki18n:5
	kde-frameworks/kio:5
	kde-frameworks/kparts:5
	kde-frameworks/kxmlgui:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	webkit? ( >=dev-qt/qtwebkit-5.212.0_pre20180120:5 )
	!webkit? (
		dev-qt/qtwebchannel:5
		dev-qt/qtwebengine:5[widgets]
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DUSE_QTWEBKIT=$(usex webkit)
	)

	ecm_src_configure
}
