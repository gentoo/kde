# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
CPPUNIT_REQUIRED="optional"
inherit kde4svn

DESCRIPTION="Common library for KDE PIM apps."
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE="${IUSE} debug htmlhandbook ldap +sasl"
LICENSE="GPL-2 LGPL-2"
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
	kde4overlay-base_src_compile
}
