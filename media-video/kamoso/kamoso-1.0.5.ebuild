# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kde4-base

DESCRIPTION="A webcam application to attract sweet girls to kde :)"
HOMEPAGE="http://gitorious.org/kamoso"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/111750-${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

DEPEND=">=media-video/vlc-1.0.0[v4l2]"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/"${PN}"
