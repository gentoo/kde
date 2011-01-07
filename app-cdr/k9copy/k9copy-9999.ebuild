# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

if [[ ${PV} != *9999* ]]; then
	KDE_LINGUAS="ca cs da de el es_AR es fr it ja nl pl pt_BR ru sr@Latn sr tr zh_TW"

	MY_P=${P}-Source

	SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

	S=${WORKDIR}/${MY_P}
else
	ESVN_REPO_URI="https://k9copy.svn.sourceforge.net/svnroot/k9copy/kde4"
	ESVN_PROJECT="k9copy"
fi

inherit kde4-base

DESCRIPTION="k9copy is a DVD backup utility which allows the copy of one or more titles from a DVD9 to a DVD5."
HOMEPAGE="http://k9copy.sourceforge.net/"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS=""
IUSE="debug +handbook"

DEPEND="
	media-libs/libdvdread
	>=media-libs/libmpeg2-0.5.1
	media-libs/xine-lib
	>=media-video/ffmpeg-0.5i
"
RDEPEND="${DEPEND}
	media-video/dvdauthor
	media-video/mplayer
"

DOCS=( README )

pkg_postinst() {
	kde4-base_pkg_postinst
	has_version '>=app-cdr/k3b-1.50' || elog "If you want K3b burning support in ${P}, please install app-cdr/k3b separately."
}
