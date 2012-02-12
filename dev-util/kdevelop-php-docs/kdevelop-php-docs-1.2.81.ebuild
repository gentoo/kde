# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_LINGUAS="ca ca@valencia da de en_GB es et fr gl it nb nds nl pt pt_BR ru sv uk zh_CN zh_TW"

KMNAME="kdevelop"
KMMODULE="php-docs"
#KDEVELOP_VERSION="4.2.3"
inherit kde4-base

DESCRIPTION="PHP documentation plugin for KDevelop 4"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2 LGPL-2"
IUSE="debug"
