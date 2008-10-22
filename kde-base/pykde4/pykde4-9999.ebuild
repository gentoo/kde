# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Based on work from the genkdesvn overlay:
# Copyright 2007-2008 by the individual contributors of the genkdesvn project
# Based in part upon the respective ebuild in Gentoo which is:
# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="1"

KMNAME=kdebindings
KMMODULE="python/pykde4"
inherit kde4svn-meta

DESCRIPTION="Python bindings for KDE4"
KEYWORDS=""
IUSE="debug"

DEPEND=">=dev-python/sip-4.7.6
	>=dev-python/PyQt4-4.4.2
	dev-lang/python"
RDEPEND="${DEPEND}"
