# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_LINGUAS="ar ca cs da de el es et ga hu ja lt nb nds nl pl pt pt_BR sk sv uk
zh_TW"
inherit kde4-base

DESCRIPTION="KDED daemon listening to XF86XK_TouchpadToggle"
HOMEPAGE="http://projects.kde.org/projects/extragear/base/ktouchpadenabler"
SRC_URI="mirror://kde/stable/extragear/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/libXi"
RDEPEND="${DEPEND}"
