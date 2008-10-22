# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit cmake-utils subversion eutils flag-o-matic

DESCRIPTION="Soprano is a library which provides a nice QT interface to RDF storage solutions."
HOMEPAGE="http://nepomuk-kde.semanticdesktop.org/xwiki/bin/view/Main/Soprano"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/${PN}"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+clucene debug doc elibc_FreeBSD redland +sesame2"

COMMON_DEPEND="
	>=media-libs/raptor-1.4.16
	x11-libs/qt-core:4
	x11-libs/qt-dbus:4
	clucene? ( >=dev-cpp/clucene-0.9.19 )
	redland? ( >=dev-libs/rasqal-0.9.15
		>=dev-libs/redland-1.0.6 )
	sesame2? ( >=virtual/jdk-1.6.0 )"
DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen )"
RDEPEND="${COMMON_DEPEND}"

pkg_setup() {
	echo
	ewarn "WARNING! This is an experimental ebuild of ${PN} SVN tree. Use at your own risk."
	ewarn "Do _NOT_ file bugs at bugs.gentoo.org because of this ebuild!"
	echo

	if ! use sesame2 && ! use redland; then
		eerror "Please select at least one of the backends: sesame2, redland"
		die "You need to select at least one backend."
	fi
}

src_compile() {
	# Fix automagic dependencies / linking
	if ! use clucene; then
		sed -e '/find_package(CLucene)/s/^/#DONOTFIND /' \
			-i "${S}/CMakeLists.txt" || die "Sed for CLucene automagic dependency failed."
	fi

	if ! use sesame2; then
		sed -e '/find_package(JNI)/ s:^:#DONOTWANT :' \
			-i "${S}"/CMakeLists.txt || die "Deactivating sesame backend failed."
	fi

	if ! use redland; then
		sed -e '/find_package(Redland)/ s:^:#DONOTWANT :' \
			-i "${S}"/CMakeLists.txt || die "Deactivating redland backend failed."
	fi

	if ! use doc; then
		sed -e '/find_package(Doxygen)/s/^/#DONOTFIND /' \
			-i "${S}/CMakeLists.txt" || die "Sed to disable api-docs failed."
	fi

	sed -e '/add_subdirectory(test)/s/^/#DONOTCOMPILE /' \
		-e '/enable_testing/s/^/#DONOTENABLE /' \
		-i "${S}"/CMakeLists.txt || die "Disabling of ${PN} tests failed."
	einfo "Disabled building of ${PN} tests."

	# Fix for missing pthread.h linking
	# NOTE: temporarely fix until a better cmake files patch will be provided.
	use elibc_FreeBSD && append-ldflags "-lpthread"

	cmake-utils_src_compile
}

src_test() {
	sed -e 's/#NOTESTS//' \
		-i "${S}"/CMakeLists.txt || die "Enabling tests failed."
	cmake-utils_src_compile
	ctest --extra-verbose || die "Tests failed."
}
