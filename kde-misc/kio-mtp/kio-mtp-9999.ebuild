# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
EGIT_REPONAME="scratch/schmidt/kio-mtp.git"
inherit kde4-base

DESCRIPTION="A MTP KIO-Client for KDE"
HOMEPAGE="http://quickgit.kde.org/index.php?p=scratch%2Fschmidt%2Fkio-mtp.git&a=summary"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

COMMONDEPEND="
	>=media-libs/libmtp-1.1.3
"
DEPEND="
	${COMMONDEPEND}
"
RDEPEND="
	${COMMONDEPEND}
"
