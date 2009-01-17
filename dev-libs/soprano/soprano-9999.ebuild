# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

JAVA_PKG_OPT_USE=sesame2
inherit cmake-utils eutils flag-o-matic subversion java-pkg-opt-2

DESCRIPTION="Soprano is a library which provides a nice QT interface to RDF storage solutions."
HOMEPAGE="http://sourceforge.net/projects/soprano"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/${PN}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+clucene debug doc elibc_FreeBSD redland +sesame2"

COMMON_DEPEND="
	x11-libs/qt-core:4[debug=]
	x11-libs/qt-dbus:4[debug=]
	clucene? ( dev-cpp/clucene )
	redland? (
		>=dev-libs/rasqal-0.9.15
		>=dev-libs/redland-1.0.6
		media-libs/raptor
	)
	sesame2? ( >=virtual/jdk-1.6.0 )
	!redland? (
		!sesame2? (
			>=virtual/jdk-1.6.0
		)
	)
"
DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen )
"
RDEPEND="${COMMON_DEPEND}"

pkg_setup() {
	echo
	ewarn "WARNING! This is an experimental ebuild of ${PN} SVN tree. Use at your own risk."
	ewarn "Do _NOT_ file bugs at bugs.gentoo.org because of this ebuild!"
	echo
}

src_configure() {
	# Fix automagic dependencies / linking
	if ! use clucene; then
		sed -e '/find_package(CLucene)/s/^/#DONOTFIND /' \
			-i "${S}/CMakeLists.txt" || die "Sed for CLucene automagic dependency failed."
	fi

	if ! use doc; then
		sed -e '/find_package(Doxygen)/s/^/#DONOTFIND /' \
			-i "${S}/CMakeLists.txt" || die "Sed to disable api-docs failed."
	fi

	if ! use redland; then
		sed -e '/find_package(Redland)/ s:^:#DONOTWANT :' \
			-i "${S}"/CMakeLists.txt || die "Deactivating redland backend failed."
	fi

	if ! use sesame2; then
		sed -e '/find_package(JNI)/ s:^:#DONOTWANT :' \
			-i "${S}"/CMakeLists.txt || die "Deactivating sesame backend failed."
	fi

	if ! use redland && ! use sesame2; then
		sed -e '/find_package(JNI)/ s:^#DONOTWANT ::' \
			-i "${S}"/CMakeLists.txt || die "Deactivating sesame backend failed."
	fi

	sed -e '/add_subdirectory(test)/s/^/#DONOTCOMPILE /' \
		-e '/enable_testing/s/^/#DONOTENABLE /' \
		-i "${S}"/CMakeLists.txt || die "Disabling of ${PN} tests failed."
	einfo "Disabled building of ${PN} tests."

	# Fix for missing pthread.h linking
	# NOTE: temporarely fix until a better cmake files patch will be provided.
	use elibc_FreeBSD && append-ldflags "-lpthread"

	cmake-utils_src_configure
}

src_test() {
	sed -e 's/#NOTESTS//' \
		-i "${S}"/CMakeLists.txt || die "Enabling tests failed."
	cmake-utils_src_compile
	ctest --extra-verbose || die "Tests failed."
}

pkg_postinst() {
	if ! use redland && ! use sesame2; then
		elog "As you haven't chosen any of the available backends:"
		elog "redland, sesame2"
		elog "sesame2 support was silently installed."
		elog "If you prefer another backend, be sure to reinstall soprano"
		elog "and to enable that backend use flag"
	fi
}
