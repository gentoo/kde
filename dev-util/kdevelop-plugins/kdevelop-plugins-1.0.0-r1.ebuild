# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="Extra plugins for KDevelop 4"
HOMEPAGE="http://www.kdevelop.org/"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="+php +php-docs"

RDEPEND="
	php? ( >=dev-util/kdevelop-php-${PV}:${SLOT} )
	php-docs? ( >=dev-util/kdevelop-php-docs-${PV}:${SLOT} )
"
