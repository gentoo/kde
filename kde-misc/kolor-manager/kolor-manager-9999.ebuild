# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KControl module for Oyranos CMS cross desktop settings."
HOMEPAGE="http://www.oyranos.org/wiki/index.php?title=Kolor-manager"

LICENSE="BSD-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	>=media-libs/oyranos-0.4.0
"
RDEPEND="${DEPEND}"
