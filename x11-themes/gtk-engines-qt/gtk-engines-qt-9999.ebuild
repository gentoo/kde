# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit eutils qt4 subversion

MY_PN="gtk-qt-engine"
DESCRIPTION="GTK+2 Qt4 Theme Engine"
HOMEPAGE="http://gtk-qt.ecs.soton.ac.uk"
ESVN_REPO_URI="http://gtk-qt.ecs.soton.ac.uk/svn/gtk-qt/trunk/${MY_PN}"

LICENSE="GPL-2"
KEYWORDS=""
IUSE=""
DEPEND=">=x11-libs/qt-4.3:4
		>=x11-libs/gtk+-2.2
		dev-util/cmake"
RDEPEND=""

SLOT="3"

S="${WORKDIR}/${MY_PN}"

src_install() {
	make DESTDIR="${D}" install
}
