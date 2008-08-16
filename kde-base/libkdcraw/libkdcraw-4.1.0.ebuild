# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME="kdegraphics"
KMMODULE=libs/libkdcraw
NEED_KDE="4.1"

inherit kde4-meta

DESCRIPTION="KDE Image Plugin Interface: a dcraw library wrapper"
HOMEPAGE="http://www.kipi-plugins.org"

LICENSE="GPL-2"
KEYWORDS="~amd64"
IUSE=""
SLOT="4.1"

DEPEND="
	media-libs/jpeg
	media-libs/lcms"
RDEPEND="${DEPEND}"

# Install to KDEDIR to slot the package
PREFIX="${KDEDIR}"
