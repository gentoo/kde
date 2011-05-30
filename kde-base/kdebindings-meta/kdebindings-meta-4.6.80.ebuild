# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit kde4-meta-pkg

DESCRIPTION="KDE bindings - merge this to pull in all kdebindings-derived packages"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="csharp java perl python ruby"

RDEPEND="
	$(add_kdebase_dep smoke)
	csharp? ( $(add_kdebase_dep kdebindings-csharp) )
	java? ( $(add_kdebase_dep krossjava) )
	perl? ( $(add_kdebase_dep kdebindings-perl) )
	python? (
		$(add_kdebase_dep krosspython)
		$(add_kdebase_dep pykde4)
	)
	ruby? ( $(add_kdebase_dep kdebindings-ruby) )
"
