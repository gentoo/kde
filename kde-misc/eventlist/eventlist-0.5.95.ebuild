# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MY_P="plasmoid-${P}"
KDE_LINGUAS="cs da de el es et fr it km nds nl pl pt pt_BR ru sk sv uk"
inherit kde4-base

DESCRIPTION="Plasmoid showing the events from Akonadi resources"
HOMEPAGE="http://kde-look.org/content/show.php/Eventlist?content=107779"
SRC_URI="http://kde-look.org/CONTENT/content-files/107779-${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdepimlibs)
	|| ( ( $(add_kdebase_dep akonadi) )
	     ( $(add_kdebase_dep kdepim-common-libs) ) )
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}
