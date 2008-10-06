# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

NEED_KDE=":4.1"
inherit kde4-base

DESCRIPTION="KRename - a very powerful batch file renamer."
HOMEPAGE="http://www.krename.net/"
SRC_URI="mirror://sourceforge/krename/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!kdeprefix? ( !kde-misc/krename:0 )
	>=media-libs/taglib-1.5"

PREFIX="${KDEDIR}"
