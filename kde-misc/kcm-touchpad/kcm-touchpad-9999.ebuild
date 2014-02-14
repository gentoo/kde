# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="KCM, daemon and applet for touchpad"
HOMEPAGE="https://projects.kde.org/projects/playground/utils/kcm-touchpad"

LICENSE="GPL-2+"
SLOT="4"
KEYWORDS=""
IUSE="debug"

DEPEND="x11-drivers/xf86-input-synaptics
	x11-libs/libxcb
"
RDEPEND="${DEPEND}"
