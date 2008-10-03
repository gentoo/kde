# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

NEED_KDE="4.1"
KMNAME="koffice"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="Shared KOffice data files."
HOMEPAGE="http://www.koffice.org/"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

KMEXTRA="servicetypes/
		pics/
		templates/"
KMEXTRACTONLY="
	doc/CMakeLists.txt
	doc/koffice.desktop"

