# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="playground/base"
KMMODULE="${PN/-/_}"
KDE_SCM="svn"
OPENGL_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="Nice kioslave showing informations about computer"
HOMEPAGE="http://websvn.kde.org/trunk/playground/base/kio_sysinfo/"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS=""
IUSE="debug"

src_configure() {
	# What the heck is HD library??
	mycmakeargs=(
		-DSYSINFO_DISTRO:STRING=generic
		-DWITH_HD=OFF
		$(cmake-utils_use_with opengl OpenGL)
	)

	kde4-base_src_configure
}
