# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kde4-meta-pkg.eclass,v 1.1 2011/04/06 14:22:14 scarabeus Exp $

# @ECLASS: kde4-meta-pkg.eclass
# @MAINTAINER:
# kde@gentoo.org
# @BLURB: This eclass contains boilerplate for kde 4.X meta packages
# @DESCRIPTION:
# This eclass should only be used for defining meta packages for KDE4.

inherit kde4-functions versionator

HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
IUSE="aqua kdeprefix"
RDEPEND="$(block_other_slots)"

SLOT=$(_calculate_kde_slot)
[[ -z ${SLOT} ]] && die "Unsupported ${PV}"
# portage dies out if last statement is like above so we need to pass true
:
