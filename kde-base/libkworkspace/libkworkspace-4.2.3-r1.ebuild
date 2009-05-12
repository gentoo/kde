# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkworkspace/libkworkspace-4.2.3.ebuild,v 1.2 2009/05/09 15:26:00 scarabeus Exp $

EAPI="2"

KMNAME="kdebase-workspace"
KMMODULE="libs/kworkspace"
inherit kde4-meta

DESCRIPTION="A library for KDE desktop applications"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug"

KMEXTRACTONLY="
	ksmserver/org.kde.KSMServerInterface.xml
	kwin/org.kde.KWin.xml
"

KMSAVELIBS="true"

src_install() {
	kde4-meta_src_install

	# workspace library hack
	cd "${D}/${KDEDIR}/$(get_libdir)/cmake/"
	targ=`find ./ -name KDE4WorkspaceLibraryTargets.cmake`
	cd ${targ/\/*/}
	cp "${FILESDIR}"/KDE4WorkspaceLibraryTargets.cmake \
		./ || die "library target copy failed"
}
