# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kdegraphics-thumbnailers"
inherit kde4-base

DESCRIPTION="KDE 4 thumbnail generators for PDF/PS files"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkdcraw)
	$(add_kdebase_dep libkexiv2)
"
RDEPEND="${DEPEND}"

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	S="${WORKDIR}/${KMNAME}-${PV}"
fi
