# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="https://github.com/euroelessar/jreen.git"
[[ ${PV} == *9999 ]] && GIT_ECLASS="git-2"
inherit qt4-r2 cmake-utils ${GIT_ECLASS}

DESCRIPTION="Qt XMPP library"
HOMEPAGE="http://gitorious.org/jreen"
[[ ${PV} == *9999 ]] || SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=x11-libs/qt-core-4.6.0
	>=x11-libs/qt-gui-4.6.0
	>=app-crypt/qca-2.0.3
	>=net-dns/libidn-1.20
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/"${PN}"
