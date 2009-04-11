# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdegraphics"
KMMODULE="thumbnailers"
inherit kde4-meta

DESCRIPTION="KDE 4 thumbnail generators for PDF/PS files"
KEYWORDS="~alpha ~amd64 ~ia64 ~x86"
IUSE="debug"

KMEXTRACTONLY="libs/mobipocket"
