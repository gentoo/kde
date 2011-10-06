# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KDE_HANDBOOK="optional"
PYTHON_DEPEND="2"
KDE_SCM="git"
if [[ ${PV} == *9999 ]]; then
	kde_eclass="kde4-base"
else
	KMNAME="kdeutils"
	kde_eclass="kde4-meta"
fi
inherit python ${kde_eclass}

DESCRIPTION="KDE printer system tray utility"
KEYWORDS=""
IUSE=""

DEPEND="
	>=app-admin/system-config-printer-common-1.2.2
	$(add_kdebase_dep pykde4)
"
RDEPEND="${DEPEND}"

pkg_setup() {
	${kde_eclass}_pkg_setup
	python_set_active_version 2
}

src_prepare() {
	${kde_eclass}_src_prepare

	# Rename printer-applet -> printer-applet-kde
	local newname="printer-applet-kde"
	local srcdir=.
	[[ ${kde_eclass} == "kde4-meta" ]] && srcdir="${KMMODULE}"
	sed -e "/PYKDE4_ADD_EXECUTABLE/s/ printer-applet[[:space:]]*)/ ${newname})/" \
		-e "/install/s/)/ RENAME ${newname}.desktop)/" \
		-i "${srcdir}"/CMakeLists.txt || die "failed to rename printer-applet executable"
	sed -e "/Exec/s/printer-applet/${newname}/" \
		-i "${srcdir}"/printer-applet.desktop || die "failed to patch .desktop file"
}

src_install() {
	${kde_eclass}_src_install
	python_convert_shebangs -q -r $(python_get_version) "${ED}"
}

pkg_postrm() {
	python_mod_cleanup "${PREFIX}share/apps/${PN}"
}
