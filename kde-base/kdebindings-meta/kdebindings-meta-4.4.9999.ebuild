# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit kde4-functions

DESCRIPTION="KDE bindings - merge this to pull in all kdebindings-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.4"
KEYWORDS=""
IUSE="aqua csharp kdeprefix java python ruby"

RDEPEND="
	$(add_kdebase_dep smoke)
	csharp? ( $(add_kdebase_dep kdebindings-csharp )
	java? ( $(add_kdebase_dep krossruby )
	python? (
		$(add_kdebase_dep krosspython
		$(add_kdebase_dep pykde4
	)
	ruby? (
		$(add_kdebase_dep krossruby
		$(add_kdebase_dep kdebindings-ruby
	)
	$(block_other_slots)
"
