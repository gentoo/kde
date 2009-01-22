# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="Hal cups utilities"
HOMEPAGE="https://fedorahosted.org/hal-cups-utils/"
SRC_URI="https://fedorahosted.org/hal-cups-utils/attachment/wiki/ProjectReleases/${P}.tar.gz?format=raw -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# TODO fix rdeps
RDEPEND="
	dev-lang/python
	>=dev-libs/dbus-glib-0.74
	>=dev-libs/glib-2.16
	dev-python/dbus-python
	dev-python/pycups
	net-print/cups
	>=sys-apps/dbus-1.2
	>=sys-apps/hal-0.5.10
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
"

src_install() {
	dodoc AUTHORS ChangeLog README || die "dodoc failed"

	emake DESTDIR="${D}" install || die "emake install failed"
}
