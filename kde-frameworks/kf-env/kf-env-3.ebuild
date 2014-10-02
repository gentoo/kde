# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Environment setting required for all KDE Frameworks apps to run"
HOMEPAGE="http://community.kde.org/Frameworks"
SRC_URI=""

LICENSE="GPL-2"
SLOT="5"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	x11-misc/xdg-utils
"

S=${WORKDIR}

src_unpack() { :; }

src_prepare() { :; }

pkg_preinst() { :; }

src_install() {
	einfo "Installing environment file..."

	# higher number to be sure not to kill kde4 env
	local envfile="${T}/78kf"

	echo "CONFIG_PROTECT=${EPREFIX}/usr/share/config" >> ${envfile}
	doenvd ${envfile}
}

src_test() { :; }
