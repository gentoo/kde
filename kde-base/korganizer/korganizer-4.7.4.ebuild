# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdepim"
KDE_SCM="git"
inherit kde4-meta

DESCRIPTION="A Personal Organizer for KDE"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs 'semantic-desktop')
	$(add_kdebase_dep kdepim-common-libs)
	sys-libs/zlib
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep ktimezoned)
"

KMLOADLIBS="kdepim-common-libs"

KMEXTRACTONLY="
	akonadi_next/
	calendarviews/
	kdgantt2/
	kmail/
	knode/org.kde.knode.xml
	libkdepimdbusinterfaces/
"

KMCOMPILEONLY="
	incidenceeditor-ng/
	calendarsupport/
"

PATCHES=(
	"${FILESDIR}/${PN}-4.5.64_missing_header.patch"
)

src_unpack() {
	if use kontact; then
		KMEXTRA="${KMEXTRA}
			kontact/plugins/planner/
			kontact/plugins/specialdates/
		"
	fi

	kde4-meta_src_unpack
}

src_install() {
	kde4-meta_src_install
	# colliding with kdepim-common-libs
	rm -rf "${ED}"/usr/share/kde4/servicetypes/calendarplugin.desktop
	rm -rf "${ED}"/usr/share/kde4/servicetypes/calendardecoration.desktop
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	if ! has_version kde-base/kdepim-kresources:${SLOT}; then
		echo
		elog "For groupware functionality, please install kde-base/kdepim-kresources:${SLOT}"
		echo
	fi
}
