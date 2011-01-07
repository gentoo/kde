# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="A GUI for querying and manipulating RDF data"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=116756"
SRC_URI="http://kde-apps.org/CONTENT/content-files/116756-${PN}.tgz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	>=kde-base/kdelibs-${KDE_MINIMAL}[semantic-desktop]
"
RDEPEND="${DEPEND}
	>=kde-base/nepomuk-${KDE_MINIMAL}
"

S="${WORKDIR}/${PN}"
