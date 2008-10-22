# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="1"

KMNAME=kdebase-workspace
KMMODULE="libs/libplasmaclock"
OPENGL_REQUIRED="optional"
inherit kde4svn-meta

DESCRIPTION="Libraries for KDE Plasma's clocks"
KEYWORDS=""
IUSE="debug xinerama"

DEPEND="kde-base/libplasma:${SLOT}"

KMSAVELIBS="true"
