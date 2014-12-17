# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkface/libkface-4.4.0.ebuild,v 1.2 2014/12/12 15:52:10 zlogene Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="Qt/C++ wrapper around LibFace to perform face recognition and detection"
HOMEPAGE="http://api.kde.org/4.x-api/kdegraphics-apidocs/libs/libkface/libkface/html/index.html"

LICENSE="GPL-2"
IUSE=""
SLOT=4

DEPEND=">=media-libs/opencv-2.4.9"
RDEPEND="${DEPEND}
	!media-libs/libkface"
