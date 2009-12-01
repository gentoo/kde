# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="KDE menu editor"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug +handbook"

RDEPEND="
	$(add_kdebase_dep khotkeys)
"

KMEXTRACTONLY="
	libs/kworkspace/
"

src_configure() {
	sed -i -e \
		"s:\${CMAKE_CURRENT_BINARY_DIR}/../khotkeys/app/org.kde.khotkeys.xml:${KDEDIR}/share/dbus-1/interfaces/org.kde.khotkeys.xml:g" \
		kmenuedit/CMakeLists.txt \
		|| die "sed failed"

	kde4-meta_src_configure
}
