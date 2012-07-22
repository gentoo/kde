# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Synaptics driver based touchpads kcontrol module.KSynaptic analog for KDE-4"
HOMEPAGE="http://kde-apps.org/content/show.php/kcm_touchpad?content=113335"
SRC_URI=""

EGIT_REPO_URI="git://github.com/mishaaq/kcm_touchpad.git"
LICENSE="GPL-3"
SLOT="4"
KEYWORDS=""
IUSE=""

DEPEND=">=x11-drivers/xf86-input-synaptics-1.0.0
		>=x11-proto/inputproto-2.0"
RDEPEND="${DEPEND}"
