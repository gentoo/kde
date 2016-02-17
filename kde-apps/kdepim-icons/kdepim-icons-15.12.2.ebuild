# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_AUTODEPS="false"
KMNAME="kdepim"
inherit kde5

DESCRIPTION="KDE PIM icons"
IUSE=""
KEYWORDS=" ~amd64 ~x86"

DEPEND="$(add_frameworks_dep extra-cmake-modules)"
RDEPEND="
	!<kde-apps/kdepim-15.12.1-r1:5
	!kde-apps/kdepim-icons:4
	!>=kde-frameworks/oxygen-icons-5.19.0:5
"

if [[ ${KDE_BUILD_TYPE} = live ]] ; then
	S="${WORKDIR}/${P}/icons"
else
	S="${WORKDIR}/${KMNAME}-${PV}/icons"
fi

src_prepare() {
	kde5_src_prepare
	cat <<-EOF > CMakeLists.txt
cmake_minimum_required(VERSION 2.8.12)
find_package(ECM REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH \${ECM_MODULE_PATH})
include(ECMInstallIcons)
include(KDEInstallDirs)
file(GLOB pim_icons *-x-mail-distribution-list.png)
ecm_install_icons(ICONS \${pim_icons} DESTINATION \${ICON_INSTALL_DIR} THEME oxygen)
EOF
}
