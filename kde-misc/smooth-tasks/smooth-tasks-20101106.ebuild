# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="cs de fr hu pl ru zh_CN"

inherit kde4-base

MY_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}"

DESCRIPTION="Alternate taskbar KDE plasmoid, similar to Windows 7"
HOMEPAGE="http://www.kde-look.org/content/show.php/Smooth+Tasks?content=101586"
SRC_URI="http://kde-look.org/CONTENT/content-files/101586-${PN}-src-wip-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	>=kde-base/libtaskmanager-${KDE_MINIMAL}
"
RDEPEND="${DEPEND}
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
"

S="${WORKDIR}/${PN}-src-wip-${MY_PV}"
