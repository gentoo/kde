# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="KDE digital camera manager"
KEYWORDS=""
IUSE="debug htmlhandbook"

DEPEND="
	media-libs/libgphoto2
"
RDEPEND="${DEPEND}"
