# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="A KDE4 Plasma Applet that controls amaroK 2 and Juk using D-Bus"
HOMEPAGE="http://www.kde-look.org/content/show.php/plasma-am4rok?content=77297"
SRC_URI="http://am4rok.googlecode.com/files/${PN}_${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!kde-misc/plasmoids
		kde-base/libplasma"

S="${WORKDIR}/${PN}"
