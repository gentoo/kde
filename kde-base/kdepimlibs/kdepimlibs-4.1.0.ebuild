# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE=":4.1"
CPPUNIT_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="Common library for KDE PIM apps."
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64"
IUSE="${IUSE} debug htmlhandbook ldap sasl"
LICENSE="LGPL-2.1"
RESTRICT="test"

DEPEND="
	app-office/akonadi-server
	>=app-crypt/gpgme-1.1.6
	dev-libs/boost
	dev-libs/libgpg-error
	ldap? ( >=net-nds/openldap-2 )
	sasl? ( >=dev-libs/cyrus-sasl-2 )"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with ldap Ldap)
		$(cmake-utils_use_with sasl Sasl2)"
	kde4-base_src_compile
}
