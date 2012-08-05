# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
KDE_LINGUAS="cs da de et hu km nl pl pt pt_BR sk sv uk"
inherit kde4-base

DESCRIPTION="A tool for managing print jobs and printers"
HOMEPAGE="https://projects.kde.org/projects/playground/base/print-manager"
[[ "${PV}" != "9999" ]] && SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

RDEPEND="
	>=net-print/cups-1.4.6[dbus]
"
DEPEND="${RDEPEND}"
