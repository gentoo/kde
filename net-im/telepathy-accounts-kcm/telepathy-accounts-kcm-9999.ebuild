# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_LINGUAS="cs da de en_GB eo es et fi fr hu it ja km lt mai nds nl pl pt pt_BR
ru sv tr ug uk zh_TW"
KDE_SCM="git"
MY_P="${PN/telepathy/telepathy-kde}-${PV}"
inherit kde4-base

DESCRIPTION="KDE Telepathy account management kcm"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://kde/unstable/telepathy-kde/${PV}/src/${MY_P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="LGPL-2.1"
SLOT="4"
IUSE="debug"

DEPEND="
	>=net-im/telepathy-common-internals-${PV}
	>=net-im/telepathy-mission-control-5.7.9
	>=net-libs/telepathy-glib-0.14
	>=net-libs/telepathy-qt4-0.7.3
"
RDEPEND="${DEPEND}
"

S=${WORKDIR}/${MY_P}
