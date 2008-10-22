# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdebindings
KMMODULE="ruby/krossruby"
inherit kde4svn-meta

DESCRIPTION="Ruby plugin for the kdelibs/kross scripting framework."
KEYWORDS=""
IUSE="debug"

DEPEND="dev-lang/ruby"
RDEPEND="${DEPEND}"
