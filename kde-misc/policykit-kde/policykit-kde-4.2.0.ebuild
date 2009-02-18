# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/skanlite/skanlite-0.2.ebuild,v 1.3 2009/02/05 08:12:34 alexxy Exp $

EAPI="2"
KDE_MINIMAL="4.2"
KDE_LINGUAS="be cs da de el es et fr ga gl it ja km lt lv
			nb nds nl nn pa pl pt pt_BR ro sk sv tr uk wa zh_CN zh_TW"

inherit kde4-base

KDE_VERSION="4.2.0"

MY_PN="PolicyKit-kde"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="KDE image scannig application"
HOMEPAGE="http://www.kde.org"
SRC_URI="mirror://kde/stable/${KDE_VERSION}/src/extragear/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-auth/policykit-0.9"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
