# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfind/kfind-4.2.0.ebuild,v 1.2 2009/02/01 07:11:54 jmbsvicetto Exp $
EAPI="2"

KMNAME="kdebase"
KMMODULE="apps/${PN}"
inherit kde4-meta

DESCRIPTION="KDE file finder utility"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

DEPEND=">=kde-base/libkonq-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRA="apps/doc/${PN}"
