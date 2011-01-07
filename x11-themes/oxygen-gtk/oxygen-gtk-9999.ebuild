# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

if [[ "${PV}" != "9999" ]]; then
	SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"
	KEYWORDS="~amd64"
else
	EGIT_REPO_URI="git://anongit.kde.org/oxygen-gtk"
	GIT_ECLASS="git"
	KEYWORDS=""
fi

inherit cmake-utils ${GIT_ECLASS}

DESCRIPTION="(yet another) Gtk port of KDE's oxygen widget style"
HOMEPAGE="https://projects.kde.org/projects/playground/artwork/oxygen-gtk"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

RDEPEND="x11-libs/gtk+
	x11-libs/cairo
	dev-libs/glib
	x11-libs/libX11
	x11-libs/pango"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
