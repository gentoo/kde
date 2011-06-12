# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"
KMNAME="kdeedu"
if [[ ${PV} == *9999 ]]; then
	kde_eclass="kde4-base"
else
	kde_eclass="kde4-meta"
fi
inherit ${kde_eclass}

DESCRIPTION="Classical hangman game for KDE"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkdeedu)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libkdeedu/keduvocdocument
"
