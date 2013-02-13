# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: kde4-meta-pkg.eclass
# @MAINTAINER:
# kde@gentoo.org
# @BLURB: This eclass contains boilerplate for kde 4.X meta packages
# @DESCRIPTION:
# This eclass should only be used for defining meta packages for KDE4.

if [[ ${___ECLASS_ONCE_KDE4_META_PKG} != "recur -_+^+_- spank" ]] ; then
___ECLASS_ONCE_KDE4_META_PKG="recur -_+^+_- spank"

inherit kde4-functions

HOMEPAGE="http://www.kde.org/"

LICENSE="metapackage"
IUSE="aqua"

SLOT=4

fi
