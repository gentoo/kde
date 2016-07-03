# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGIT_REPO_URI="https://github.com/oyranos-cms/Synnefo.git"
inherit cmake-utils
[[ ${PV} == "9999" ]] && inherit git-r3

DESCRIPTION="Qt front end for the Oyranos Color Management System"
HOMEPAGE="https://github.com/oyranos-cms/Synnefo"
[[ ${PV} == 9999 ]] || \
SRC_URI="https://github.com/oyranos-cms/Synnefo/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
[[ ${PV} == 9999 ]] || KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	>=media-libs/oyranos-0.9.6
"
RDEPEND="${DEPEND}
	x11-misc/xcalib
"

DOCS=( AUTHORS.md README.md )
