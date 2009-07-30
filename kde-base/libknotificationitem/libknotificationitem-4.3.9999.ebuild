# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

if [[ ${PV} = *9999* ]]; then
	KMNAME="kdelibs/experimental"
else
	KMNAME="kdelibs-experimental"
fi

KMMODULE="knotificationitem"
inherit kde4-meta

DESCRIPTION="Notification library"
KEYWORDS=""
IUSE="debug"
