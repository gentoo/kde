# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} == *9999 ]]; then
	KMNAME="kde-dev-util"
else
	KMNAME="kde-dev-utils"
fi
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="KDE miscellaneous SDK tools"
KEYWORDS=""
IUSE="debug"
