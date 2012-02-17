# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"

if [[ $PV == *9999 ]]; then
	SRC_URI=""
	KEYWORDS=""
else
	EGIT_REPO_URI="git://anongit.kde.org/kdevelop-pg-qt.git"
	EGIT_COMMIT="v${PV}"
	SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${PN}-v${PV}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

inherit kde4-base

DESCRIPTION="A LL(1) parser generator used mainly by KDevelop language plugins"
HOMEPAGE="http://www.kdevelop.org"
LICENSE="LGPL-2"
SLOT="0"
IUSE="debug"

RDEPEND=""
DEPEND="
	sys-devel/bison
	sys-devel/flex
"
S=${WORKDIR}/${PN}-v${PV}