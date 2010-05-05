# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/sdk"
KMMODULE="kdevelop-plugins"
inherit kde4-base

KDEVELOP_PV="4.0.0"

DESCRIPTION="PHP documentation plugin for KDevelop 4"
HOMEPAGE="http://www.kdevelop.org/"
SRC_URI="mirror://kde/stable/kdevelop/${KDEVELOP_PV}/src/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	>=dev-util/kdevplatform-${PV}:${SLOT}
"
RDEPEND="${DEPEND}
	!=dev-util/kdevelop-plugins-1.0.0
"
