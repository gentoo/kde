# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME="extragear/multimedia"
NEED_KDE="svn"

inherit kde4svn-meta

# Install to KDEDIR rather than /usr, to slot properly.
PREFIX="${KDEDIR}"

DESCRIPTION="KDE CD ripper and audio encoder frontend"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="kde-svn"

IUSE=""

DEPEND="
	kde-base/libkcompactdisc:${SLOT}
	kde-base/libkcddb:${SLOT}
	"
