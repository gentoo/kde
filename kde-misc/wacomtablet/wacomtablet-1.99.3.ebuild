# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS="bs cs da de el en_GB eo es et fi fr ga gl hu ja kk km lt mai nb nds nl pa pl pt
pt_BR ro sk sl sv tr ug uk zh_CN zh_TW"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KControl module for wacom tablets"
HOMEPAGE="http://kde-apps.org/content/show.php?action=content&content=114856"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/114856-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	dev-libs/libwacom
	sys-devel/gettext
	x11-drivers/xf86-input-wacom
"
RDEPEND="${DEPEND}"
