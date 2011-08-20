# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

# use domme's/dschmidt's clone for now, until the CMake support is merge
# back to minimoog's original repository. See also:
# https://github.com/minimoog/QTweetLib/network
#EGIT_REPO_URI="git://github.com/minimoog/QTweetLib.git"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="http://dev.gentoo.org/~jmbsvicetto/distfiles/snapshots/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	GIT_ECLASS="git-2"
	EGIT_REPO_URI="git://github.com/dschmidt/QTweetLib.git"
	KEYWORDS=""
fi

inherit qt4-r2 cmake-utils ${GIT_ECLASS}

DESCRIPTION="Qt based Twitter library"
HOMEPAGE="https://github.com/minimoog/QTweetLib"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

DEPEND="
	>=dev-libs/qjson-0.7.1
	>=x11-libs/qt-core-4.6.0[ssl]
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/"${PN}"
