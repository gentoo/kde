# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_MINIMAL="4.8"
KDE_SCM="git"
EGIT_REPONAME="${PN/-kde/}"
inherit kde4-base

DESCRIPTION="LightDM KDE greeter"
HOMEPAGE="https://projects.kde.org/projects/playground/base/lightdm"
[[ ${PV} = 9999* ]] || SRC_URI="mirror://kde/unstable/${PN}/src/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND=">=x11-misc/lightdm-1.3.2[qt4]"
RDEPEND="${DEPEND}"
