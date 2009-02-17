# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

MY_P="Panelspacer_from_svn_pour_kdelook-tmp"

DESCRIPTION="A KDE4 Plasma Applet let you put some blank space between the other applets located in a panel"
HOMEPAGE="http://www.kde-look.org/content/show.php/Panel+Spacer?content=89304"
SRC_URI="http://danakil.free.fr/linux/releases/${P}/${PN}-plasmoid-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_prepare()
{
	epatch "${FILESDIR}/cmake_fix_for_kde-4_2.patch"
}
