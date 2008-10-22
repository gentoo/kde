# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdeedu
inherit kde4svn-meta

# get weird "Exception: Other". broken.
RESTRICT="test"

DESCRIPTION="Common library for KDE educational applications."
KEYWORDS=""
IUSE="debug"

src_install() {
        kde4overlay-meta_src_install
        # This is installed by kde-base/marble
        rm "${D}"/usr/kde/svn/share/apps/cmake/modules/FindMarbleWidget.cmake
}
