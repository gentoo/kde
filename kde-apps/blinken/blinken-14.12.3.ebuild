# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE version of the Simon Says game"
HOMEPAGE="http://www.kde.org/applications/education/blinken
http://edu.kde.org/blinken"
KEYWORDS=" ~amd64 ~x86"
IUSE="debug"

src_install() {
	kde4-base_src_install

	rm "${D}"/usr/share/apps/${PN}/README.packagers
}
