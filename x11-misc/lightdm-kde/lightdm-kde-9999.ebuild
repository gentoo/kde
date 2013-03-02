# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_MINIMAL="4.8"
EGIT_REPONAME="${PN/-kde/}"
KDE_LINGUAS="cs da de el es et fi fr ga hu it ja km lt nds nl pl pt pt_BR ro sk sv uk"
inherit kde4-base

DESCRIPTION="LightDM KDE greeter"
HOMEPAGE="https://projects.kde.org/projects/playground/base/lightdm"
[[ ${PV} = 9999* ]] || SRC_URI="mirror://kde/unstable/${PN}/src/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	x11-libs/libX11
	dev-qt/qtdeclarative:4
	>=x11-misc/lightdm-1.3.2[qt4]
"
RDEPEND="${DEPEND}"
