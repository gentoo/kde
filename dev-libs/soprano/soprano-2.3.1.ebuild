# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/soprano/soprano-2.3.0-r1.ebuild,v 1.2 2009/09/12 10:13:15 armin76 Exp $

EAPI="2"

JAVA_PKG_OPT_USE="java"
inherit base cmake-utils flag-o-matic java-pkg-opt-2

DESCRIPTION="Library that provides a nice QT interface to RDF storage solutions"
HOMEPAGE="http://sourceforge.net/projects/soprano"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
SLOT="0"
IUSE="+clucene +dbus debug doc elibc_FreeBSD +java +raptor redland"

COMMON_DEPEND="
	x11-libs/qt-core:4
	clucene? ( dev-cpp/clucene )
	dbus? ( x11-libs/qt-dbus:4 )
	raptor? ( >=media-libs/raptor-1.4.16 )
	redland? (
		>=dev-libs/rasqal-0.9.15
		>=dev-libs/redland-1.0.6
	)
	java? ( >=virtual/jdk-1.6.0 )
"

DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen )
"
RDEPEND="${COMMON_DEPEND}
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

	if ! use java; then
		if ! use redland; then
			echo
			ewarn "You explicitly disabled default soprano backend and haven't chosen other one."
			ewarn "Applications using soprano may need at least one backend functional."
			ewarn "If you experience any problems, enable any of those USE flags:"
			ewarn "java (recommended), redland"
			echo
		else
			echo
			ewarn "You selected redland as default backend for soprano."
			ewarn "Be advised that it's known to be broken (bug #275326)."
			echo
		fi
	fi
}

src_prepare() {
	# Temporarily disable raptor serializer automagic
	if ! use redland; then
		sed -e '/set(BUILD_RAPTOR_SERIALIZER TRUE)/d' \
			-i CMakeLists.txt || die "failed to disable raptor serializer"
	fi

	base_src_prepare
}

src_configure() {
	# Fix for missing pthread.h linking
	# NOTE: temporarily fix until a better cmake files patch will be provided.
	use elibc_FreeBSD && append-ldflags "-lpthread"

	mycmakeargs="${mycmakeargs}
		-DSOPRANO_BUILD_TESTS=OFF
		-DCMAKE_SKIP_RPATH=OFF
		$(cmake-utils_use !clucene SOPRANO_DISABLE_CLUCENE_INDEX)
		$(cmake-utils_use !dbus SOPRANO_DISABLE_DBUS)
		$(cmake-utils_use !raptor SOPRANO_DISABLE_RAPTOR_PARSER)
		$(cmake-utils_use !redland SOPRANO_DISABLE_REDLAND_BACKEND)
		$(cmake-utils_use !java SOPRANO_DISABLE_SESAME2_BACKEND)
		$(cmake-utils_use doc SOPRANO_BUILD_API_DOCS)
	"

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_test() {
	mycmakeargs="${mycmakeargs}
		-DSOPRANO_BUILD_TESTS=ON"
	cmake-utils_src_configure
	cmake-utils_src_compile
	ctest --extra-verbose || die "Tests failed."
}
