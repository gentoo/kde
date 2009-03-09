# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-runtime"
KMMODULE="phonon"
inherit kde4-meta

DESCRIPTION="Phonon KDE Integration"
HOMEPAGE="http://phonon.kde.org"
LICENSE="GPL-3"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	!kdeprefix? ( !kde-base/phonon-xine[-kdeprefix] )
"

src_prepare() {
	# Don't build tests - they require OpenGL
	sed -i -e 's/add_subdirectory(tests)//'\
		phonon/CMakeLists.txt || die "Failed to disable tests"

	kde4-meta_src_prepare
}

src_install() {
	kde4-meta_src_install

	# fix missing backends
	if use kdeprefix; then
		dosym /usr/share/kde4/services/phononbackends \
		"${KDEDIR}"/share/kde4/services/phononbackends || die
	fi
}
