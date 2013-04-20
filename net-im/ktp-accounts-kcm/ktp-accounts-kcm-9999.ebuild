# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_MINIMAL="4.7"
KDE_LINGUAS="ca cs da de el en_GB eo es et fi fr ga gl hu it ja km lt mai nb nds
nl pl pt pt_BR ru sk sr sr@ijekavian sr@ijekavianlatin sr@latin sv tr ug uk vi
zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="KDE Telepathy account management kcm"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://kde/unstable/kde-telepathy/${PV}/src/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="LGPL-2.1"
SLOT="4"
IUSE="debug"

DEPEND="
	>=net-im/ktp-common-internals-${PV}
	net-im/telepathy-mission-control
	net-libs/telepathy-glib
	>=net-libs/telepathy-qt-0.9.3
"
RDEPEND="${DEPEND}
"
