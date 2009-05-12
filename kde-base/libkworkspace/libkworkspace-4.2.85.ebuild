# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-workspace"
KMMODULE="libs/kworkspace"
inherit kde4-meta

DESCRIPTION="A library for KDE desktop applications"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

KMEXTRACTONLY="
	ksmserver/org.kde.KSMServerInterface.xml
	kwin/org.kde.KWin.xml
"

KMSAVELIBS="true"

src_prepare() {
	sed -i -e 's/install( FILES kdisplaymanager.h/install( FILES kdisplaymanager.h screenpreviewwidget.h/' \
		libs/kworkspace/CMakeLists.txt || die "failed to provide screenpreviewwidget.h"

	kde4-meta_src_prepare
}

src_install() {
	kde4-meta_src_install

	# workspace library hack
	cd "${D}/${KDEDIR}/$(get_libdir)/cmake/"
	local targ=`find ./ -name KDE4WorkspaceLibraryTargets.cmake`
	cd ${targ/\/*/}
	cp "${FILESDIR}"/KDE4WorkspaceLibraryTargets.cmake \
		./ || die "library target copy failed"
}
