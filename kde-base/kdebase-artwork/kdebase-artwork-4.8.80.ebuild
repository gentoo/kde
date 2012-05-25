# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME=${PN/kdebase/kde-base}
KDE_SCM="svn"
inherit kde4-base

DESCRIPTION="KDE base artwork"
IUSE=""
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
