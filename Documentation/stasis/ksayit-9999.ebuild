# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
KMNAME=kdeaccessibility
EAPI="1"
inherit kde4svn-meta

DESCRIPTION="KDE text-to-speech frontend."
KEYWORDS=""
IUSE=""

DEPEND=">=kde-base/kttsd-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
