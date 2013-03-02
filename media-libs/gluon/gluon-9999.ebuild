# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

OPENGL_REQUIRED="always"
inherit kde4-base versionator

DESCRIPTION="Gluon is a Free and Open Source framework for creating and distributing games."
HOMEPAGE="http://gluon.tuxfamily.org/"

LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="4"
IUSE="debug examples"

DEPEND="
	media-libs/alure
	media-libs/libsndfile
	media-libs/openal
	virtual/glu
	virtual/opengl
	dev-qt/qtdeclarative:4
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use examples INSTALL_EXAMPLES)
	)

	kde4-base_src_configure
}
