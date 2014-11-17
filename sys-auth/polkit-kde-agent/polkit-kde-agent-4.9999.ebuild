# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_PN="${PN}-1"
MY_P="${MY_PN}-${PV}"
EGIT_REPONAME="${MY_PN}"
KDE_LINGUAS="ca ca@valencia cs da de en_GB eo es et fi fr ga
	gl hr hu is it ja km lt nb mai ms nds nl pa pt pt_BR ro ru
	sk sr sr@ijekavian sr@ijekavianlatin sr@latin sv th tr uk zh_TW"
inherit kde4-base

DESCRIPTION="PolKit agent module for KDE"
HOMEPAGE="http://www.kde.org"
if [[ ${KDE_BUILD_TYPE} != live ]] ; then
	SRC_URI="mirror://kde/stable/apps/KDE4.x/admin/${MY_P}.tar.bz2"
fi

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	>=sys-auth/polkit-qt-0.103.0
"
RDEPEND="${DEPEND}
	!sys-auth/polkit-kde
"

if [[ ${KDE_BUILD_TYPE} != live ]] ; then
	S=${WORKDIR}/${MY_P}
fi
