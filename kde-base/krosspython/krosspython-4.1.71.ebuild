# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME=kdebindings
KMMODULE=python/${PN}
NEED_KDE="4.2"
inherit kde4-meta

DESCRIPTION="Kross scripting framework: Python interpreter"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="dev-lang/python"

KMEXTRACTONLY="python/pykde4"
