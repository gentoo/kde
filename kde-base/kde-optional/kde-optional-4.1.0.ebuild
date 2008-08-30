# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

DESCRIPTION="KDE - optional packages"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

KEYWORDS="~amd64"
SLOT="4.1"
IUSE="accessibility"

RDEPEND="
	accessibility? ( >=kde-base/kdeaccessibility-meta-${PV}:${SLOT} )
"
