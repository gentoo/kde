# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="Kopete plugin - Flash Thinklight on new message"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=100537"
SRC_URI="http://www.vohnout.cz/premek/gentoo/${PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	>=kde-base/kopete-${KDE_MINIMAL}
"
RDEPEND="${DEPEND}"

pkg_postinst() {
	kde4-base_pkg_postinst

	echo
	elog "The plugin writes to and reads from the light's device file."
	elog "The device file must be adjusted for normal users."
	elog "This device file lives inside the /proc space, permissions can't be changed permanently"
	elog "Execute the helper program \"kopete_thinklight_fixpermissions\""
	elog "This gives ordinary users read/write permissions to the device file."
	echo
}
