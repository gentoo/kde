# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kdesdk"
KMMODULE="strigi-analyzer"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="kdesdk: strigi plugins"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	app-misc/strigi
"
RDEPEND="${DEPEND}"
