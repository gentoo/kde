# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KDE_LINGUAS="ar bg bs ca ca@valencia cs da de el en_GB es et fi fr gl it lt nb
nds nl pa pl pt pt_BR ro ru sk sl sr sr@ijekavian sr@ijekavianlatin sr@latin sv
tr uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="KDE utility for management of partitions and file systems"
HOMEPAGE="https://www.kde.org/applications/system/kde${PN}"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	dev-libs/libatasmart
	sys-apps/util-linux
	>=sys-block/parted-3
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"
