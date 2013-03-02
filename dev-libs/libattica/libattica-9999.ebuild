# Copyright 1999-2013 Gentoo Foundation
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

RDEPEND="dev-qt/qtcore:4"
DEPEND="${RDEPEND}
	dev-qt/qttest:4"

DOCS=(AUTHORS ChangeLog README)
