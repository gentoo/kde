# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_LINGUAS="cs da de et fr hu it ja km lt nds nl pl pt pt_BR sv ug uk"
KDE_SCM="git"
MY_P="${PN/telepathy/telepathy-kde}-${PV}"
inherit kde4-base

DESCRIPTION="KDE Telepathy contact list"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://kde/unstable/telepathy-kde/${PV}/src/${MY_P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	EGIT_REPO_URI="git://anongit.kde.org/${PN/telepathy/ktp}"
	KEYWORDS=""
fi

LICENSE="GPL-2"
SLOT="4"
IUSE="debug"

DEPEND="
	>=net-im/telepathy-accounts-kcm-${PV}
	>=net-im/telepathy-common-internals-${PV}
	>=net-libs/telepathy-qt4-0.9.0
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}
