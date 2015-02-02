# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KDE_LINGUAS="bg bs ca ca@valencia cs da de el en_GB eo es et fi fr ga
gl hr hu it ja ko lt mai nb nds nl pa pl pt pt_BR ro ru sk sl sr
sr@ijekavian sr@ijekavianlatin sr@latin sv tr ug uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE with many extras"
HOMEPAGE="http://www.krusader.org/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="+bookmarks debug"

RDEPEND="
	|| ( kde-base/libkonq:4 kde-apps/libkonq:4 )
	sys-libs/zlib
	bookmarks? ( || ( kde-base/keditbookmarks:4 kde-apps/keditbookmarks:4 ) )
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"
