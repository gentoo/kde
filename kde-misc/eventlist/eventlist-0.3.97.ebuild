# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_MINIMAL="4.6"
MY_P="plasmoid-${P}"
KDE_LINGUAS="cs de fr it ru sk uk"
inherit kde4-base

DESCRIPTION="show the events from Akonadi resources"
HOMEPAGE="http://kde-look.org/content/show.php/Eventlist?content=107779"
SRC_URI="http://kde-look.org/CONTENT/content-files/107779-${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdepimlibs)
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}
