# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} == *9999 ]]; then
	KMNAME="kdesupport"
fi
KDE_AUTODEPS="false"
KDE_SCM="svn"
inherit kde5

DESCRIPTION="Oxygen SVG icon theme"
HOMEPAGE="http://www.oxygen-icons.org/"
if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="
		bindist? ( ${SRC_URI} )
	"
fi

LICENSE="LGPL-3"
KEYWORDS=" ~amd64 ~x86"
IUSE="bindist"

RDEPEND="!kde-base/oxygen-icons:4"
