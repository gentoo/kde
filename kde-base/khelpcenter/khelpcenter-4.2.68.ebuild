# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="The KDE Help Center"
IUSE="debug"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-lang/perl
	>=www-misc/htdig-3.2.0_beta6-r1
"

KMEXTRA="
	doc/faq
	doc/glossary
	doc/quickstart
	doc/userguide
	doc/visualdict
"
