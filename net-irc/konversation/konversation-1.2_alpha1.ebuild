# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base versionator

#MY_P="${PN}-1.2-alpha1"
MY_P="${PN}"-$(replace_version_separator 2 '-')

DESCRIPTION="A user friendly IRC Client for KDE4"
HOMEPAGE="http://konversation.kde.org"
SRC_URI="http://download2.berlios.de/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

S="${WORKDIR}/${MY_P}"
