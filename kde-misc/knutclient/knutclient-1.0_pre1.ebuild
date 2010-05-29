# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

MY_P="1_0_KDE4_pre1"

DESCRIPTION="A visual KDE client for UPS system NUT"
HOMEPAGE="http://www.knut.noveradsl.cz/knutclient/"
SRC_URI="ftp://ftp.buzuluk.cz/pub/alo/${PN}/devel/${PN}-${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	media-libs/qimageblitz
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}_${MY_P}

PATCHES=( "${FILESDIR}/${P}-xdg-desktop-entry.patch" )
