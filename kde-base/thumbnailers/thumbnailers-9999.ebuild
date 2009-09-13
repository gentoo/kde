# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="KDE 4 thumbnail generators for PDF/PS files"
KEYWORDS=""
IUSE="debug"

KMEXTRACTONLY="
	libs/mobipocket
"

DEPEND="
	$(add_kdebase_dep libkdcraw)
	$(add_kdebase_dep libkexiv2)
"
RDEPEND="${DEPEND}
	!kdeprefix? ( !<kde-base/kdegraphics-strigi-analyzer-4.2.91[-kdeprefix] )
	kdeprefix? ( !<kde-base/kdegraphics-strigi-analyzer-4.2.91:${SLOT}[kdeprefix] )
"
