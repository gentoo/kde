# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm kde.org

DESCRIPTION="Plasma 5 applet for controlling redshift"
HOMEPAGE="https://store.kde.org/p/998916/"

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS=""
IUSE=""

DEPEND="kde-frameworks/plasma:5"
RDEPEND="${DEPEND}
	x11-misc/redshift
"
