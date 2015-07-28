# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdepim"
EGIT_BRANCH="KDE/4.14"
inherit kde4-meta

DESCRIPTION="KTimeTracker tracks time spent on various tasks"
HOEMPAGE="http://www.kde.org/applications/utilities/ktimetracker/"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdepim-kresources)
	$(add_kdebase_dep kdepimlibs '-minimal(-)')
	$(add_kdebase_dep kdepim-common-libs)
	x11-libs/libXScrnSaver
"
DEPEND="${RDEPEND}
	x11-proto/scrnsaverproto
"

KMEXTRACTONLY="
	kresources/
"

KMLOADLIBS="kdepim-common-libs"

src_unpack() {
	if use kontact; then
		KMEXTRA="${KMEXTRA} kontact/plugins/ktimetracker"
	fi

	kde4-meta_src_unpack
}
