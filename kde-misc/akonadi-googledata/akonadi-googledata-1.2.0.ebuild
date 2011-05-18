# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_LINGUAS="ca ca@valencia cs da de en_GB eo es et fi fr ga gl hr hu is km lt
lv nb nds nl pt pt_BR ro sk sr sr@ijekavian sr@ijekavianlatin sr@latin sv th
tr uk zh_CN zh_TW"

inherit kde4-base

DESCRIPTION="Google contacts and calendar akonadi resource"
HOMEPAGE="http://pim.kde.org/akonadi/"
SRC_URI="http://libgcal.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	dev-libs/boost
	dev-libs/libxslt
	$(add_kdebase_dep kdepimlibs semantic-desktop)
	>=net-libs/libgcal-0.9.6
"
RDEPEND="${DEPEND}
	!kde-misc/googledata
"
