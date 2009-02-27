# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kappfinder/kappfinder-4.2.0.ebuild,v 1.2 2009/02/01 06:31:15 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdebase"
KMMODULE="apps/${PN}"
inherit kde4-meta

DESCRIPTION="KDE tool that looks for well-known apps in your path and creates entries for them in the KDE menu"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

DEPEND=""
RDEPEND="${DEPEND}"

KMEXTRA="apps/doc/${PN}"
