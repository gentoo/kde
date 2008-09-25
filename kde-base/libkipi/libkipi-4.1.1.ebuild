# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2_pre3"

KMNAME="kdegraphics"
KMMODULE=libs/libkipi

inherit kde4-meta

DESCRIPTION="A library for image plugins accross KDE applications"
HOMEPAGE="http://www.kipi-plugins.org/"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!kdeprefix? ( !media-libs/libkipi )"
RDEPEND="${DEPEND}"
