# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KDE_ORG_CATEGORY=office
KFMIN=5.90.0
QTMIN=5.15.2
inherit ecm kde.org

DESCRIPTION="Cross-platform, aesthetic, distraction-free markdown editor"
HOMEPAGE="https://ghostwriter.kde.org/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	app-text/hunspell:=
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtsvg-${QTMIN}:5
	>=dev-qt/qtwebchannel-${QTMIN}:5
	>=dev-qt/qtwebengine-${QTMIN}:5[widgets]
	>=dev-qt/qtwidgets-${QTMIN}:5
	virtual/opengl
"
DEPEND="${RDEPEND}
	>=dev-qt/qtconcurrent-${QTMIN}:5
"
BDEPEND="
	>=dev-qt/linguist-tools-${QTMIN}:5
	virtual/pkgconfig
"

DOCS=( CREDITS.md README.md )
