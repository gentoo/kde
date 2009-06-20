# Copyright 1999-2009 Gentoo Foundation
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
IUSE=""

DEPEND=""
RDEPEND=">kde-base/kopete-${KDE_MINIMAL}
"

pkg_postinst(){

elog "The plugin writes to and reads from the light's device file. By default, these"
elog "permissions are only given to root. Since kopete runs with normal user"
elog "privilliges, however, reads and writes would fail. Hence, the permissions of"
elog "the device file must be adjusted for normal users."

elog "Since the device file lives inside the /proc space, permissions can't be"
elog "changed permanently (they are gone after a reboot). The solution is to execute"
elog "the helper program \"kopete_thinklight_fixpermissions\" whenever the thinklight"
elog "plugin is loaded, which gives ordinary users read/write permissions to the"
elog "device file. For this to work, the helper program needs to have the suid-bit"
elog "set."

}
