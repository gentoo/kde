# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/base"
inherit kde4-meta

DESCRIPTION="Various plugins for konqueror"
HOMEPAGE="http://kde.org/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	>=kde-base/libkonq-${KDE_MINIMAL}
"
RDEPEND="${DEPEND}
	!kde-base/konq-plugins:4.1[-kdeprefix]
	!kde-base/konq-plugins:4.2[-kdeprefix]
	>=kde-base/kcmshell-${KDE_MINIMAL}
	>=kde-base/konqueror-${KDE_MINIMAL}
"
