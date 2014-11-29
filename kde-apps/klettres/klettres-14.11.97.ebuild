# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE: KLettres helps a very young child or an adult learning "
HOMEPAGE="http://www.kde.org/applications/education/klettres
http://edu.kde.org/klettres"
KEYWORDS=" ~amd64 ~x86"
IUSE="debug"

RDEPEND="
	$(add_kdeapps_dep knotify)
"
