# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

OPENGL_REQUIRED="always"
inherit kde4-base

DESCRIPTION="Gluon is a Free and Open Source framework for creating and distributing games"
HOMEPAGE="http://gluon.tuxfamily.org/"

LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="4"
IUSE="debug examples"

DEPEND="
	dev-qt/qtdeclarative:4
	media-libs/alure
	media-libs/libsndfile
	media-libs/openal
	virtual/glu
	virtual/opengl
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use examples INSTALL_EXAMPLES)
	)

	kde4-base_src_configure
}
