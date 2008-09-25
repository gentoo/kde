# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2_pre3"

NEED_KDE="4.1"
KDE_LINGUAS="ca cs da de el en_GB fr ga gl ja ko nds nl pt pt_BR ro ru sv tr uk"
inherit kde4-base

DESCRIPTION="A quake-style terminal emulator based on KDE konsole technology"
HOMEPAGE="http://yakuake.kde.org/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4.1"
IUSE=""

DEPEND=">=kde-base/konsole-4.1.0
	!kdeprefix? ( !kde-misc/yakuake:0 )
	sys-devel/gettext"
RDEPEND="${DEPEND}"

# take care of wrong prefixing
PREFIX="${KDEDIR}"
