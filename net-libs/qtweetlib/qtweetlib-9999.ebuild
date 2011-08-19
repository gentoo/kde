# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

# use domme's/dschmidt's clone for now, until the CMake support is merge
# back to minimoog's original repository. See also:
# https://github.com/minimoog/QTweetLib/network
#EGIT_REPO_URI="git://github.com/minimoog/QTweetLib.git"
EGIT_REPO_URI="git://github.com/dschmidt/QTweetLib.git"
[[ ${PV} == *9999 ]] && GIT_ECLASS="git-2"
inherit qt4-r2 cmake-utils ${GIT_ECLASS}

DESCRIPTION="Qt based Twitter library"
HOMEPAGE="https://github.com/minimoog/QTweetLib"
[[ ${PV} == *9999 ]] || SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=dev-libs/qjson-0.7.1
	>=x11-libs/qt-core-4.6.0[ssl]
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/"${PN}"
