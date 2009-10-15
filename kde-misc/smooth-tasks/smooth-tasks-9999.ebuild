# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="cs de fr hu pl ru"

inherit kde4-base mercurial

DESCRIPTION="KDE plasmoid. Windows 7 like taskbar, fork of stasks"
HOMEPAGE="http://www.kde-look.org/content/show.php/Smooth+Tasks?content=101586"
EHG_REPO_URI="http://bitbucket.org/panzi/${PN}/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	>=kde-base/libtaskmanager-${KDE_MINIMAL}
"
RDEPEND="${DEPEND}
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
"

S="${WORKDIR}/${PN}"
