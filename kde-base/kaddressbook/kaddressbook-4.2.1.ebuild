# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kaddressbook/kaddressbook-4.2.0.ebuild,v 1.2 2009/02/01 06:27:22 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="The KDE Address Book"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug gnokii htmlhandbook"

DEPEND=">=kde-base/libkdepim-${PV}:${SLOT}
	>=kde-base/libkleo-${PV}:${SLOT}
	gnokii? ( app-mobilephone/gnokii )"
RDEPEND="${DEPEND}"

# xml targets from kmail are being uncommented by kde4-meta.eclass
KMEXTRACTONLY="kmail/
	libkdepim/
	libkleo/"
KMLOADLIBS="libkdepim libkleo"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with gnokii GNOKII)"

	kde4-meta_src_configure
}

src_install() {
	kde4-meta_src_install

	# install additional generated header that is needed by kresources
	insinto "${KDEDIR}"/include/${PN}
	doins "${WORKDIR}"/${PN}_build/${PN}/common/kabprefs_base.h || \
	die "Failed to install extra header files"
}
