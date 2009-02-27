# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kolourpaint/kolourpaint-4.2.0.ebuild,v 1.2 2009/02/01 07:40:53 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="Paint Program for KDE"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"
LICENSE="BSD LGPL-2"

DEPEND="kde-base/qimageblitz"
RDEPEND="${DEPEND}"
