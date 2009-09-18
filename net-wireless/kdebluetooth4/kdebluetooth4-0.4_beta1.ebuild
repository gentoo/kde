# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="playground/network"
KMMODULE="kbluetooth"
KDE_MINIMAL="4.3"

MY_P="${KMMODULE}-${PV/_/}"
inherit kde4-base

DESCRIPTION="KDE Bluetooth Framework"
HOMEPAGE="http://bluetooth.kmobiletools.org/"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/112110-${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug semantic-desktop"

DEPEND="
	>=app-mobilephone/obex-data-server-0.4.2
	>=app-mobilephone/obexftp-0.23_alpha[bluetooth]
	>=kde-base/kdelibs-${KDE_MINIMAL}[semantic-desktop?]
	>=kde-base/solid-${KDE_MINIMAL}[bluetooth]
"
RDEPEND="${DEPEND}
	>=kde-base/kdialog-${KDE_MINIMAL}
	>=kde-base/konqueror-${KDE_MINIMAL}
	>=kde-base/nepomuk-${KDE_MINIMAL}
"

S="${WORKDIR}/${MY_P}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with semantic-desktop Nepomuk)
	"
	kde4-base_src_configure
}
