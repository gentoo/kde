# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libbluedevil/libbluedevil-1.9.4.ebuild,v 1.6 2014/01/30 12:56:54 mrueg Exp $

EAPI=5

inherit kde4-base

MY_P=${PN}-${PV/_/-}
DESCRIPTION="Qt wrapper for bluez used in the KDE bluetooth stack"
HOMEPAGE="http://projects.kde.org/projects/playground/libs/libbluedevil"
SRC_URI="mirror://kde/unstable/${PN}/${PV/_/-}/src/${MY_P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND=">=net-wireless/bluez-5"

S=${WORKDIR}/${MY_P}
