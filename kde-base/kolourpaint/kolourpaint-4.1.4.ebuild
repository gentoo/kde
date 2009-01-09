# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kolourpaint/kolourpaint-4.1.3.ebuild,v 1.2 2008/11/16 07:51:16 vapier Exp $

EAPI="2"

KMNAME=kdegraphics
inherit kde4-meta eutils

DESCRIPTION="Paint Program for KDE"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"
LICENSE="BSD LGPL-2"

DEPEND="kde-base/qimageblitz"
RDEPEND="${DEPEND}"
