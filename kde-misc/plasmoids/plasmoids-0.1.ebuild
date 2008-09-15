# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="4.1"
inherit kde4-base

DESCRIPTION="Useful plasma applets"
HOMEPAGE="http://kde-look.org/ http://ivplasma.googlecode.com/"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/85802-Timer.tar.bz2
	http://kde-look.org/CONTENT/content-files/83246-flickrplasmoid.tar.gz
	http://kde-look.org/CONTENT/content-files/89304-panelspacer0.1.tar.gz
	http://am4rok.googlecode.com/files/plasma-am4rok_0.5.tar.bz2
	http://kde-look.org/CONTENT/content-files/84128-quickaccess-0.7.1.tar.gz
	http://hlukotvor.no-ip.org/plasma-weather-0.4.tar.gz
	http://ivplasma.googlecode.com/files/toggle-compositing-0.2.1.tar.gz
	http://www.kde-look.org/CONTENT/content-files/79476-plasma-wifi-0.5.tgz"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=kde-base/libplasma-4.1.1
	>=kde-base/plasma-workspace-4.1.1"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6.1"

PREFIX="${KDEDIR}"
S="${WORKDIR}"

get_dirs() {
	find "${S}" -mindepth 1 -maxdepth 1 -type d |grep -v plasmoids_build \
		|while read DIR; do
			echo "<<< WORKING IN ${DIR} >>>"
			cd "${DIR}"
			${@}
		done
}

src_unpack() {
	unpack ${A}
}
src_compile() {
	get_dirs "cmake . -DCMAKE_INSTALL_PREFIX=${PREFIX}"
	get_dirs "make"
}
src_install() {
	get_dirs "make DESTDIR=${D} install"
}

pkg_postinst() {
	kde4-base_pkg_postinst
	elog "For now this package contains this plasmoids:"
	elog "Timer"
	elog "Flickr"
	elog "Panel spacer"
	elog "Am4rok"
	elog "Quickaccess"
	elog "Weather"
	elog "Toggle Composing"
	elog "Plasma Wifi"
}
