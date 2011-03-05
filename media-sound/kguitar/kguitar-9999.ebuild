# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
KDE_LINGUAS="de es it fr ru"

inherit kde4-base subversion
ESVN_REPO_URI="https://kguitar.svn.sourceforge.net/svnroot/kguitar/branches/kde4"

DESCRIPTION="Guitarist helper program focusing on tabulature editing and MIDI synthesizers support"
HOMEPAGE="http://kguitar.sf.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="midi"

DEPEND="midi? ( >=media-libs/tse3-0.3.0 )"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="$(cmake-utils_use midi WITH_TSE3)"
	kde4-base_src_configure
}
