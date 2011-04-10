# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KDE_HANDBOOK="optional"
if [[ ${PV} == *9999 ]]; then
	KDE_SCM="git"
	inherit kde4-base
else
	KMNAME="kdeedu"
	inherit kde4-meta
fi

DESCRIPTION="KDE Educational: vocabulary trainer"
KEYWORDS=""
IUSE="debug +plasma"

DEPEND="
	$(add_kdebase_dep libkdeedu)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kvtml-data)
"

KMEXTRACTONLY="
	libkdeedu/keduvocdocument
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with plasma)
	)

	kde4-meta_src_configure
}
