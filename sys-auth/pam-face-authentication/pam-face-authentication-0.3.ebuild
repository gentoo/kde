# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils

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
	>=sys-libs/pam-0.99.8
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-0.3-cmake.patch"
)

DOCS=(AUTHORS ChangeLog README)
