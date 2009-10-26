# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

GIT_HASH="mishaaq-${PN}-504052d"
inherit kde4-base

DESCRIPTION="Synaptics driver based touchpads kcontrol module.KSynaptic analog for KDE-4"
HOMEPAGE="http://kde-apps.org/content/show.php/kcm_touchpad?content=113335"
SRC_URI="http://github.com/mishaaq/${PN}/tarball/${P} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-drivers/xf86-input-synaptics-1.0.0[hal]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${GIT_HASH}"
