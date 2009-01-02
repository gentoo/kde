# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

CPPUNIT_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="Common library for KDE PIM apps."
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~x86"
IUSE="${IUSE} debug htmlhandbook ldap +sasl"
LICENSE="LGPL-2.1"
RESTRICT="test"

DEPEND="
	>=app-office/akonadi-server-1.0.80
	>=app-crypt/gpgme-1.1.6
	dev-libs/boost
	dev-libs/libgpg-error
	>=dev-libs/libical-0.33-r1
	ldap? ( net-nds/openldap )
	sasl? ( dev-libs/cyrus-sasl )
	!kdeprefix? ( !kde-base/akonadi:4.1 )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with ldap Ldap)
		$(cmake-utils_use_with sasl Sasl2)"
	kde4-base_src_configure
}
