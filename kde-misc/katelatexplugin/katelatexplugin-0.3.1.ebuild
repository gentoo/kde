# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_LINGUAS="fr"
inherit kde4-base

DESCRIPTION="Kate LaTeX typesetting plugin"
HOMEPAGE="http://www.kde-apps.org/content/show.php/Kate+LaTeX+typesetting+plugin?content=84772"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/84772-${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kate)
"

S="${WORKDIR}/${PN}"
