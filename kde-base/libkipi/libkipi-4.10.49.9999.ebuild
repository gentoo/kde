# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="A library for image plugins accross KDE applications."
KEYWORDS=""
IUSE="debug"

PATCHES=( "${FILESDIR}/${PN}-4.10.0-uname.patch" )
