# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ $PV != *9999 ]]; then
	KMNAME="kdenetwork"
	KDE_ECLASS=meta
else
	KDE_ECLASS=base
fi

KDE_HANDBOOK="optional"
inherit kde4-${KDE_ECLASS}

DESCRIPTION="VNC-compatible server to share KDE desktops"
KEYWORDS=""
IUSE="debug telepathy"

DEPEND="
	sys-libs/zlib
	virtual/jpeg
	!aqua? (
		x11-libs/libX11
		x11-libs/libXdamage
		x11-libs/libXext
		x11-libs/libXtst
	)
	telepathy? ( >=net-libs/telepathy-qt-0.9 )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with telepathy TelepathyQt4)
	)

	kde4-${KDE_ECLASS}_src_configure
}
