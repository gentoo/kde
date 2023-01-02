# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KDE_ORG_CATEGORY="aacid"
inherit desktop ecm kde.org

DESCRIPTION="CHM file viewer based on KDE Frameworks and QtWebEngine"
HOMEPAGE="https://tsdgeos.blogspot.com/2020/05/chmk-simple-chm-viewer.html
https://invent.kde.org/aacid/chmk"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtgui:5
	dev-qt/qtwebengine:5[widgets]
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/kcrash:5
	kde-frameworks/ki18n:5
	kde-frameworks/kwidgetsaddons:5
	kde-frameworks/kxmlgui:5
"
RDEPEND="${DEPEND}"

src_install() {
	ecm_src_install
	make_desktop_entry ${PN} "ChmK" "" "Qt;KDE;Office;Viewer;" \
		"MimeType=application/chm;application/x-chm;application/vnd.ms-htmlhelp;application/epub+zip"
}
