# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KTimeTracker tracks time spent on various tasks."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug +handbook"

RDEPEND="
	$(add_kdebase_dep kdepim-kresources)
	$(add_kdebase_dep libkdepim)
	x11-libs/libXScrnSaver
"
DEPEND="${RDEPEND}
	x11-proto/scrnsaverproto
"

KMEXTRACTONLY="
	kresources/
"

KMLOADLIBS="libkdepim"

src_unpack() {
	if use kontact; then
		KMLOADLIBS="${KMLOADLIBS} kontactinterfaces"
		KMEXTRA="${KMEXTRA} kontact/plugins/ktimetracker"
	fi

	kde4-meta_src_unpack
}
