# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/soprano/soprano-2.4.3.ebuild,v 1.3 2010/05/06 18:43:13 reavertm Exp $

EAPI="2"

JAVA_PKG_OPT_USE="java"
inherit base cmake-utils flag-o-matic java-pkg-opt-2

DESCRIPTION="Library that provides a nice Qt interface to RDF storage solutions"
HOMEPAGE="http://sourceforge.net/projects/soprano"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
SLOT="0"
IUSE="clucene +dbus debug doc elibc_FreeBSD java +raptor +redland +virtuoso"

COMMON_DEPEND="
	>=x11-libs/qt-core-4.5.0:4
	clucene? ( dev-cpp/clucene )
	dbus? ( >=x11-libs/qt-dbus-4.5.0:4 )
	raptor? ( >=media-libs/raptor-1.4.16 )
	redland? (
		>=dev-libs/rasqal-0.9.15
		>=dev-libs/redland-1.0.10
	)
	java? ( >=virtual/jdk-1.6.0 )
	virtuoso? ( dev-db/libiodbc:0 )
"
DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen )
"
RDEPEND="${COMMON_DEPEND}
	virtuoso? ( >=dev-db/virtuoso-server-6.1.0 )
"

CMAKE_IN_SOURCE_BUILD="1"

pkg_setup() {
	java-pkg-opt-2_pkg_setup

	if [[ ${PV} = *9999* && -z $I_KNOW_WHAT_I_AM_DOING ]]; then
		echo
		ewarn "WARNING! This is an experimental ebuild of ${PN} SVN tree. Use at your own risk."
		ewarn "Do _NOT_ file bugs at bugs.gentoo.org because of this ebuild!"
		echo
	fi

	if ! use java && ! use virtuoso; then
		if ! use redland; then
			echo
			ewarn "You have explicitly disabled the default soprano backend and haven't chosen"
			ewarn "a different one. Applications using soprano may need at least one backend"
			ewarn "to be functional. If you experience any problems, enable any of those USE"
			ewarn "flags:"
			ewarn "java (deprecated), redland, virtuoso (recommended)"
			echo
		else
			echo
			ewarn "You selected redland as the only backend for soprano."
			ewarn "Be advised that it's known to be broken (bug #275326)."
			echo
		fi
	fi
}

src_prepare() {
	base_src_prepare
}

src_configure() {
	# Fix for missing pthread.h linking
	# NOTE: temporarily fix until a better cmake files patch will be provided.
	use elibc_FreeBSD && append-flags -pthread

	mycmakeargs=(
		-DSOPRANO_BUILD_TESTS=OFF
		-DCMAKE_SKIP_RPATH=OFF
		$(cmake-utils_use !clucene SOPRANO_DISABLE_CLUCENE_INDEX)
		$(cmake-utils_use !dbus SOPRANO_DISABLE_DBUS)
		$(cmake-utils_use !raptor SOPRANO_DISABLE_RAPTOR_PARSER)
		$(cmake-utils_use !redland SOPRANO_DISABLE_RAPTOR_SERIALIZER)
		$(cmake-utils_use !redland SOPRANO_DISABLE_REDLAND_BACKEND)
		$(cmake-utils_use !java SOPRANO_DISABLE_SESAME2_BACKEND)
		$(cmake-utils_use !virtuoso SOPRANO_DISABLE_VIRTUOSO_BACKEND)
		$(cmake-utils_use doc SOPRANO_BUILD_API_DOCS)
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_test() {
	mycmakeargs+=(-DSOPRANO_BUILD_TESTS=ON)
	cmake-utils_src_configure
	cmake-utils_src_compile
	ctest --extra-verbose || die "Tests failed."
}
