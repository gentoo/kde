# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base git

DESCRIPTION="Gmail notifier applet/plasmoid for kde"
HOMEPAGE="http://sourceforge.net/projects/kcheckgmail"
EGIT_REPO_URI="git://git.debian.org/users/lpereira-guest/kcheckgmail.git"
EGIT_BRANCH="kde4-port"
EGIT_TREE="${EGIT_BRANCH}"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

RDEPEND="
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
"

