# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="A simple and compact system monitor for Linux."
HOMEPAGE="http://kde-look.org/content/show.php/Simple+monitor?content=84933"

SRC_URI="http://kde-look.org/CONTENT/content-files/84933-simplemonitor-0.1.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( kde-base/kdelibs:live kde-base/libplasma:4.1 )"
RDEPEND="${DEPEND}"


S="${WORKDIR}/monitor"

src_prepare() {
	# Follow naming convention
	sed -i 's/DESTINATION \${SERVICES_INSTALL_DIR}/\0 RENAME plasma-applet-simplemonitor.desktop/' CMakeLists.txt || die "sed failed"

	kde4-base_src_prepare
}
