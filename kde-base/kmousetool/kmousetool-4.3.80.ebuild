# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeaccessibility"

inherit kde4-meta

DESCRIPTION="KDE program that clicks the mouse for you."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug +handbook"

RDEPEND="
	$(add_kdebase_dep knotify)
"
