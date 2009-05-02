# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="Nepomuk KDE4 client"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	|| (
		dev-libs/soprano[clucene,dbus,raptor,redland]
		dev-libs/soprano[clucene,dbus,raptor,java]
	)
	>=kde-base/kdelibs-${PV}:${SLOT}[kdeprefix=,semantic-desktop]
	!kdeprefix? ( !<=kde-base/akonadi-${PV}:${SLOT}[kdeprefix=] )
"
RDEPEND="${DEPEND}"
