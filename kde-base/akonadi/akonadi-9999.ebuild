# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="An extensible cross-desktop storage service for PIM data and meta data"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=app-office/akonadi-server-1.2.1
	$(add_kdebase_dep kdelibs 'semantic-desktop')
	$(add_kdebase_dep kdepimlibs 'akonadi')
	$(add_kdebase_dep libkdepim)
	$(add_kdebase_dep messageviewer)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdepim-runtime)
"

KMEXTRA="
	akonadiconsole/
"

KMEXTRACTONLY="
	messageviewer/
"

# @since 4.3 - blocks kdemaildir - no longer provided (it's in akonadi now)
add_blocker kdemaildir
add_blocker kdepim-kresources '<4.2.95'

src_configure() {
	mycmakeargs=(
		# Set the dbus dirs, otherwise it searches in KDEDIR
		-DAKONADI_DBUS_INTERFACES_INSTALL_DIR="${EPREFIX}/usr/share/dbus-1/interfaces"
		-DAKONADI_DBUS_SERVICES_INSTALL_DIR="${EPREFIX}/usr/share/dbus-1/services"
	)

	kde4-meta_src_configure
}
