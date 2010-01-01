# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_MINIMAL="4.3"
inherit kde4-base

DESCRIPTION="show the events from Akonadi resources"
HOMEPAGE="http://kde-look.org/content/show.php/Eventlist?content=107779"
SRC_URI="http://kde-look.org/CONTENT/content-files/107779-plasmoid-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

S="${WORKDIR}"/"plasmoid-${P}"
