# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdebase-runtime
inherit kde4-meta

DESCRIPTION="Nepomuk KDE4 client"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

# dev-cpp/clucene provides the optional strigi backend.
# As there's currently no other *usable* strigi backend, I've added it as a hard
# dependency.
DEPEND=">=app-misc/strigi-0.5.10
	dev-cpp/clucene
	>=dev-libs/soprano-2.0.98"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ! built_with_use app-misc/strigi qt4 ; then
		eerror "you need app-misc/strigi built with qt4 USE flag "
		die "no dbus and qt4 support in strigi"
	fi

	if ! built_with_use dev-libs/soprano clucene ; then
		eerror "you need dev-libs/soprano built with clucene USE flag"
		die "no clucene support in soprano"
	fi
}
