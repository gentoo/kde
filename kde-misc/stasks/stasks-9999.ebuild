# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_MINIMAL="4.3"
inherit kde4-base mercurial

DESCRIPTION="KDE plasmoid. Windows 7 like taskbar"
HOMEPAGE="http://www.kde-look.org/content/show.php/Smooth+Tasks?content=101586"
EHG_REPO_URI="http://bitbucket.org/panzi/smooth-tasks/"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND=">=kde-base/plasma-workspace-${KDE_MINIMAL}"

S="${WORKDIR}/${PN}"
