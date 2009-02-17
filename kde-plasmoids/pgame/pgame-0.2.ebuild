# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

MY_W="${P}"

DESCRIPTION="A KDE4 Plasma Applet. PGame is a Plasmoid similar to xgame."
HOMEPAGE="http://kde-look.org/content/show.php/PGame?content=99357"
SRC_URI="http://kde-look.org/CONTENT/content-files/99357-pgame-${PV}.tar.bz2"
LICENSE="GPL"

SLOT="0"
KEYWORDS="~x86 ~amd64"

W="${WORKDIR}/${MY_W}"

