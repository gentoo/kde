# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdebase-runtime
inherit kde4svn-meta

DESCRIPTION="The KDE notification daemon."
IUSE="debug"
KEYWORDS=""

DEPEND="media-sound/phonon"
RDEPEND="${DEPEND}"
