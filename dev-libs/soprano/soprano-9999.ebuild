# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

JAVA_PKG_OPT_USE="sesame2"
inherit base cmake-utils flag-o-matic subversion java-pkg-opt-2

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
"
DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen )
"
RDEPEND="${COMMON_DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-make-optional-targets.patch" )

CMAKE_IN_SOURCE_BUILD="1"

pkg_setup() {
	echo
	ewarn "WARNING! This is an experimental ebuild of ${PN} SVN tree. Use at your own risk."
	ewarn "Do _NOT_ file bugs at bugs.gentoo.org because of this ebuild!"
	echo
	if ! use redland && ! use sesame2; then
		ewarn "You explicitly disabled default soprano backend and haven't chosen other one."
		ewarn "Applications using soprano may need at least one backend functional."
		ewarn "If you experience any problems, enable any of those USE flags:"
		ewarn "redland, sesame2"
	fi
}

src_prepare() {
	base_src_prepare
}

src_configure() {
	# Fix for missing pthread.h linking
	# NOTE: temporarely fix until a better cmake files patch will be provided.
	use elibc_FreeBSD && append-ldflags "-lpthread"

	mycmakeargs="${mycmakeargs}
		-DENABLE_tests=OFF
		$(cmake-utils_use_enable clucene CLucene)
		$(cmake-utils_use_enable redland Redland)
		$(cmake-utils_use_enable sesame2 Sesame2)
		$(cmake-utils_use_enable doc docs)"

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_test() {
	mycmakeargs="${mycmakeargs}
		-DENABLE_tests=ON"
	cmake-utils_src_configure
	cmake-utils_src_compile
	ctest --extra-verbose || die "Tests failed."
}
