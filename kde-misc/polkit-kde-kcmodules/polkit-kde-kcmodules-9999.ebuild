# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_PN="${PN}-1"
MY_P="${MY_PN}-${PV}"
EGIT_REPONAME="${MY_PN}"
KDE_LINGUAS="da en_GB et gl lt nl pt pt_BR sk sv uk zh_TW"

inherit kde4-base

DESCRIPTION="PolKit agent module for KDE."
HOMEPAGE="http://www.kde.org"
[[ ${PV} == *9999* ]] ||
	SRC_URI="mirror://kde/stable/apps/KDE4.x/admin/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	>=sys-auth/polkit-kde-agent-0.99
	>=sys-auth/polkit-qt-0.103
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
