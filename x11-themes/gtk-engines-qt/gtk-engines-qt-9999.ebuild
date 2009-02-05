# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="bg cs de es fr it ko nn pt_BR ru sv tr zh_CN"

inherit kde4-base

MY_PN="gtk-qt-engine"
DESCRIPTION="GTK+2 Qt4 Theme Engine"
HOMEPAGE="http://gtk-qt.ecs.soton.ac.uk"
ESVN_REPO_URI="http://gtk-qt.ecs.soton.ac.uk/svn/gtk-qt/trunk/${MY_PN}"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="debug gnome"
SLOT="live"

RDEPEND="
	x11-libs/gtk+:2
	gnome? ( =gnome-base/libbonoboui-2* )
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

CMAKE_IN_SOURCE_BUILD="1"
S="${WORKDIR}/${MY_PN}"

src_configure() {
	sed -i \
		-e "s:\${XDG_APPS_INSTALL_DIR}:${KDEDIR}/share/kde4/services/:g" \
		kcm_gtk/CMakeLists.txt || die "sed failed"
	# BONOBOUI is automagic
	cmake-utils_src_configure
}
