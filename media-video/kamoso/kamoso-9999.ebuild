# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base git

DESCRIPTION="A webcam application to attract sweet girls to kde :)"
HOMEPAGE="http://gitorious.org/kamoso"
EGIT_REPO_URI="git://gitorious.org/kamoso/mainline.git"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="0"
IUSE="debug"

DEPEND="
	>=media-video/vlc-1.0.0[v4l2]"

RDEPEND="${DEPEND}"
