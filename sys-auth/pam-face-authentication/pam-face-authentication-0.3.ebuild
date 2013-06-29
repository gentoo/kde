# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils eutils

DESCRIPTION="This is Pluggable Authentication Module for Face based Authentication"
HOMEPAGE="http://code.google.com/p/pam-face-authentication/"
SRC_URI="http://pam-face-authentication.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	>=media-libs/opencv-1.0.0
	>=sci-libs/gsl-1.9
	virtual/pam
"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog README )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.3-cmake.patch
	epatch "${FILESDIR}"/${PN}-0.3-opencv.patch

	cp /usr/share/OpenCV/OpenCVConfig.cmake cmake/modules/FindOpenCV.cmake || die
	sed -i cmake/modules/FindOpenCV.cmake \
		-e 's:${OpenCV_INSTALL_PATH}:/usr:' || die
}
