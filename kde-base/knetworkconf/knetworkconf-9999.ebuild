# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeadmin"
inherit kde4-meta

DESCRIPTION="KDE control Center Module to confiure Network settings"
KEYWORDS=""
IUSE="debug htmlhandbook"

PATCHES=( "${FILESDIR}/backends-scriptsdir.patch" )
