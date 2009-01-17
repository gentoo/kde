# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME="playground/pim/kblogger"
NEED_KDE="svn"
inherit kde4svn

# Install to KDEDIR rather than /usr, to slot properly.
PREFIX="${KDEDIR}"

DESCRIPTION="KBlogger is a simple to use blogging application for the K Destkop Environment."
HOMEPAGE="http://kblogger.pwsp.net/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="kde-svn"
IUSE=""

DEPEND="kde-base/kdelibs:${SLOT}
	kde-base/kdepimlibs:${SLOT}"
RDEPEND="${DEPEND}"
