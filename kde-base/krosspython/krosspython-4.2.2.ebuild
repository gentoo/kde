# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krosspython/krosspython-4.2.1.ebuild,v 1.4 2009/03/15 16:34:16 ranger Exp $

EAPI="2"

KMNAME="kdebindings"
KMMODULE="python/krosspython"
inherit kde4-meta

DESCRIPTION="Kross scripting framework: Python interpreter"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	dev-lang/python
"
RDEPEND="${DEPEND}"
