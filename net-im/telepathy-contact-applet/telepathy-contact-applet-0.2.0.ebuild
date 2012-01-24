# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
MY_P="${PN/telepathy/telepathy-kde}-${PV}"
inherit kde4-base

DESCRIPTION="KDE Telepathy contact applet"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://kde/unstable/telepathy-kde/${PV}/src/${MY_P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="GPL-2"
SLOT="4"
IUSE="debug"

DEPEND="
	>=net-libs/telepathy-qt-0.7.3
"
RDEPEND="${DEPEND}
	>=net-im/telepathy-contact-list-${PV}
"

S=${WORKDIR}/${MY_P}
