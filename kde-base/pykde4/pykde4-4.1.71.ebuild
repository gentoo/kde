# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME=kdebindings
KMMODULE=python/${PN}
inherit kde4-meta

DESCRIPTION="Python language bindings for KDE's libraries"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND="dev-lang/python
	>=dev-python/sip-4.7.6
	>=dev-python/PyQt4-4.4.2"
