# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

NEED_OPENGL="always"
KDE_MINIMAL="4.1"
inherit kde4-base

DESCRIPTION="Set of plasma themes packed for ease install"
HOMEPAGE="http://kde-look.org/"
SRC_URI="
	http://www.kde-look.org/CONTENT/content-files/84403-Arezzo.tar.gz
	http://www.kde-look.org/CONTENT/content-files/81388-Glassified.tar.gz
	http://www.kde-look.org/CONTENT/content-files/83976-Glaze-0.4.tar.bz2
	http://www.kde-look.org/CONTENT/content-files/84680-Professional.tar.gz
	http://www.kde-look.org/CONTENT/content-files/83552-Metalized.tar.gz
	http://www.kde-look.org/CONTENT/content-files/79274-Perfection41.tar.gz
	http://www.kde-look.org/CONTENT/content-files/77690-spoons-0.1.tar.bz2
	http://hlukotvor.no-ip.org/fluffybunny-0.0.3.tar.bz2
	"

LICENSE="GPL-3"
SLOT="4.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=kde-base/plasma-workspace-${KDE_MINIMAL}"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

get_dirs() {
	find "${S}" -mindepth 1 -maxdepth 1 -type d |grep -v plasma-themes_build \
			|while read DIR; do
		elog "Installing theme: ${DIR/*\//}"
		cd "${DIR}"
		insinto "${KDEDIR}"/share/apps/desktoptheme/"${DIR/*\//}"
		doins -r dialogs/ || die "dialogs/ install failed"
		[ -d opaque/ ] && { doins -r opaque/ || die  "opaque/ install failed"; }
		doins -r widgets/ || die "widgets/ install failed"
		[ -e colors ] && { doins colors || die "colors files install failed"; }
		doins metadata.desktop || die "metadata install failed"
	done
}

src_unpack() {
	unpack ${A}
}

src_install() {
	get_dirs
}
