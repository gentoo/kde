# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwrite/kwrite-4.0.5.ebuild,v 1.1 2008/06/05 22:35:18 keytoaster Exp $

EAPI="1"

KMNAME=kdebase
KMMODULE=apps/${PN}
inherit kde4-meta

DESCRIPTION="KDE MDI editor/ide"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

KMEXTRA="apps/doc/${PN}"
