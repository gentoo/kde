# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Framework for reading and writing configuration"
LICENSE="LGPL-2+"
KEYWORDS=" ~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-qt/qtgui:5
	dev-qt/qtxml:5
"
DEPEND="${RDEPEND}
	test? ( dev-qt/qtconcurrent:5 )
"

DOCS=( DESIGN docs/DESIGN.kconfig docs/options.md )
