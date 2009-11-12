# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kio-ftps/kio-ftps-0.2.ebuild,v 1.1 2009/05/30 09:45:56 scarabeus Exp $

EAPI="2"

KMNAME="playground/base"
KMMODULE="${PN/-/_}"

OPENGL_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="Nice kioslave showing informations about computer"
HOMEPAGE="http://websvn.kde.org/trunk/playground/base/kio_sysinfo/"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_configure() {
	# What the heck is HD library??
	mycmakeargs+="
		-DSYSINFO_DISTRO:STRING=generic
		-DWITH_HD=OFF
		$(cmake-utils_use_with opengl OpenGL)
	"

	kde4-base_src_configure
}
