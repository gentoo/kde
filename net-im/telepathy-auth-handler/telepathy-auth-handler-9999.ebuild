# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_LINGUAS="cs da de hu it lt nds nl pt pt_BR sv uk"
KDE_SCM="git"
MY_P="${PN/telepathy/telepathy-kde}-${PV}"
inherit kde4-base

DESCRIPTION="KDE Telepathy authentication handler"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://kde/unstable/telepathy-kde/${PV}/src/${MY_P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	EGIT_REPO_URI="git://anongit.kde.org/${PN/telepathy/ktp}"
	KEYWORDS=""
fi

LICENSE="LGPL-2.1"
SLOT="4"
IUSE="debug"

DEPEND="
	>=net-im/telepathy-common-internals-${PV}
	>=net-libs/telepathy-qt-0.9.0
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}
