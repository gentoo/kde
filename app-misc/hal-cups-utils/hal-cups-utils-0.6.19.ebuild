# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="Hal cups utilities"
HOMEPAGE="https://fedorahosted.org/hal-cups-utils/"
SRC_URI="https://fedorahosted.org/hal-cups-utils/attachment/wiki/ProjectReleases/${P}.tar.gz?format=raw -> ${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

COMMON_DEPEND="
	>=dev-libs/dbus-glib-0.74
	>=dev-libs/glib-2.16
	net-print/cups
	>=sys-apps/dbus-1.2
	>=sys-apps/hal-0.5.10
"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
"
RDEPEND="${COMMON_DEPEND}
	app-admin/system-config-printer-common
"

src_install() {
	dodoc AUTHORS ChangeLog README || die "dodoc failed"

	emake DESTDIR="${D}" install || die "emake install failed"
}
