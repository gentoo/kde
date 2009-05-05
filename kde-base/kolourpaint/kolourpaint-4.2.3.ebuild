# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kolourpaint/kolourpaint-4.2.2.ebuild,v 1.2 2009/04/17 06:06:15 alexxy Exp $

EAPI="2"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="Paint Program for KDE"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
LICENSE="BSD LGPL-2"
IUSE="debug doc"

DEPEND="
	kde-base/qimageblitz
"
RDEPEND="${DEPEND}"
