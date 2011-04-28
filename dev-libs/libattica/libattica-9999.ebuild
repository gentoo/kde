# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils git-2

DESCRIPTION="A library providing access to Open Collaboration Services"
HOMEPAGE="http://kde.org/"
EGIT_REPO_URI="git://anongit.kde.org/attica"

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

DEPEND="
	x11-libs/qt-core:4
"
RDEPEND="${DEPEND}"

DOCS=(AUTHORS ChangeLog README)
