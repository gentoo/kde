# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-runtime"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="Icons, localization data and various .desktop files from kdebase."
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"

RDEPEND="
	$(add_kdebase_dep oxygen-icons)
	x11-themes/hicolor-icon-theme
"

# Some files were moved from dolphin to kdebase-data between the 4.1.85 and the 4.1.87
# releases. Thus we need to block older versions of dolphin, including the :4.1 versions.
add_blocker dolphin '<4.1.87'

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
	# Remove remnants of hicolor-icon-theme
	sed -e "s:add_subdirectory[[:space:]]*([[:space:]]*hicolor[[:space:]]*):#donotwant:g" \
		-i pics/CMakeLists.txt \
		|| die "failed to remove remnants of hicolor-icon-theme"

	kde4-meta_src_configure
}
