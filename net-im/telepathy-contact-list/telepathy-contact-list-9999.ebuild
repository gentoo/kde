# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base
#EGIT_REPO_URI="git://anongit.kde.org/clones/telepathy-contact-list/mklapetek/telepathy-contact-list-new"

DESCRIPTION="UI for contaclist"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE="debug"

DEPEND="
	>=net-libs/telepathy-qt4-0.7.1
	>=net-im/telepathy-accounts-kcm-9999
"
RDEPEND="${DEPEND}"
