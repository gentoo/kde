# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="Nepomuk KDE4 client"
HOMEPAGE+=" http://userbase.kde.org/Nepomuk"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=dev-libs/soprano-2.9.0[dbus,raptor,redland,virtuoso]
	$(add_kdebase_dep kdelibs)
	$(add_kdebase_dep nepomuk-core)
	!kde-misc/nepomukcontroller
"
RDEPEND="${DEPEND}"
