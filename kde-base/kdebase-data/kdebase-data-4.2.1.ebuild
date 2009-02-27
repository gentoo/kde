# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-data/kdebase-data-4.2.0.ebuild,v 1.2 2009/02/01 06:51:23 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdebase-runtime"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="Icons, localization data and various .desktop files from kdebase."
IUSE=""
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

# Some files were moved from dolphin to kdebase-data between the 4.1.85 and the 4.1.87
# releases. Thus we need to block older versions of dolphin, including the :4.1 versions.
RDEPEND="
	!<kde-base/dolphin-4.1.87:4.2[kdeprefix=]
	!kdeprefix? ( !<kde-base/dolphin-4.1.87[-kdeprefix] )
	x11-themes/hicolor-icon-theme
"

KMEXTRA="
	l10n/
	pics/
"
# Note that the eclass doesn't do this for us, because of KMNOMODULE="true".
KMEXTRACTONLY="
	config-runtime.h.cmake
	kde4
"

src_configure() {
	# remove instalation of colliding file for hicolor-icon-theme
	if ! use kdeprefix; then
		sed -i \
			-e "s:add_subdirectory( hicolor ):#donotwant:g" \
			pics/CMakeLists.txt
	fi

	kde4-meta_src_configure
}
