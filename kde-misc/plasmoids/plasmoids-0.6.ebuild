# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

NEED_KDE=":4.1"
NEED_OPENGL="always"
inherit kde4-base

DESCRIPTION="Useful plasma applets"
HOMEPAGE="http://kde-look.org/ http://ivplasma.googlecode.com/"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/85802-Timer.tar.bz2
	http://kde-look.org/CONTENT/content-files/83246-flickrplasmoid.tar.gz
	http://kde-look.org/CONTENT/content-files/89304-panelspacer0.1.tar.gz
	http://am4rok.googlecode.com/files/plasma-am4rok_0.5.tar.bz2
	http://ivplasma.googlecode.com/files/plasma-am3rok-0.4.1.tar.gz
	http://kde-look.org/CONTENT/content-files/84128-quickaccess-0.7.1.tar.gz
	http://hlukotvor.no-ip.org/plasma-weather-0.4.tar.gz
	http://ivplasma.googlecode.com/files/toggle-compositing-0.2.1.tar.gz
	http://www.kde-look.org/CONTENT/content-files/79476-plasma-wifi-0.5.tgz
	http://ivplasma.googlecode.com/files/plasma-netgraph-0.3.tar.gz
	http://kde-look.org/CONTENT/content-files/86628-cpuload-0.1.tar.bz2
	http://www.kde-look.org/CONTENT/content-files/91009-iHateTheCashew.tbz
	http://www.kde-look.org/CONTENT/content-files/75728-plasmatvgr.tar.gz
	"

LICENSE="GPL-2 GPL-3"
SLOT="4.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="kde-base/libplasma:${SLOT}[opengl]
	kde-base/plasma-workspace:${SLOT}
	x11-libs/qt-webkit"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6.1"

S="${WORKDIR}"

get_dirs() {
	find "${S}" -mindepth 1 -maxdepth 1 -type d |grep -v plasmoids_build \
			|while read DIR; do
		cd "${DIR}"
		${@} || die "${@} failed"
	done
}

src_unpack() {
	unpack ${A}
}

src_configure() {
	get_dirs "cmake . -DCMAKE_INSTALL_PREFIX=${PREFIX}"
}

src_compile() {
	get_dirs "make"
}

src_install() {
	get_dirs make DESTDIR="${D}" install
}

pkg_postinst() {
	kde4-base_pkg_postinst
	find "${S}" -mindepth 1 -maxdepth 1 -type d |grep -v plasmoids_build \
			|while read DIR; do
		elog "Plasma applet: ${DIR/*\//}"
	done
}
