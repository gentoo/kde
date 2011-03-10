# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

if [[ ${PV} == *9999 ]]; then
# Not sure how to handle this
KDE_HANDBOOK="required"
KDE_SCM="git"
kde_eclass="kde4-base"
else
KDE_HANDBOOK="optional"
KMNAME="kdegraphics"
kde_eclass="kde4-meta"
fi
inherit ${kde_eclass}

DESCRIPTION="KDE Screenshot Utility"
KEYWORDS=""
IUSE="debug kipi"

DEPEND="
	kipi? ( $(add_kdebase_dep libkipi) )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with kipi)
	)

	${kde_eclass}_src_configure
}
