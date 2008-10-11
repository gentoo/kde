# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

NEED_KDE="4.1"
inherit kde4-base

DESCRIPTION="PowerDevil is an utility for KDE4 for Laptop Powermanagement"
HOMEPAGE="http://www.kde-apps.org/content/show.php/PowerDevil?content=85078"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/85078-${P}-kde4.1.1.tar.bz2"

LICENSE="GPL-3"
SLOT="4.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="kde-base/systemsettings:${SLOT}
	kde-base/kscreensaver:${SLOT}"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/"${P}"-kde4.1.1

src_configure() {
	local mycmakeargs
	mycmakeargs="${mycmakeargs}
		-DDBUS_INTERFACES_INSTALL_DIR=${KDEDIR}/share/dbus-1/interfaces/"

	kde4-base_src_configure
}
