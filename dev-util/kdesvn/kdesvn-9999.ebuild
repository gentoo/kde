# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="cs de es fr ja lt nl ro ru"
inherit kde4-base

DESCRIPTION="KDESvn is a frontend to the subversion vcs."
HOMEPAGE="http://www.alwins-world.de/wiki/programs/kdesvn"
ESVN_REPO_URI="http://www.alwins-world.de/repos/kdesvn/trunk/"
ESVN_PROJECT="kdesvn"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="2"
IUSE="debug doc"

RDEPEND="
	dev-db/sqlite
	>=dev-util/subversion-1.4
	>=kde-base/kdesdk-kioslaves-${KDE_MINIMAL}
"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6
"

src_prepare() {
	sed -e 's/ADD_SUBDIRECTORY(doc)/MACRO_OPTIONAL_ADD_SUBDIRECTORY(doc)/' \
		-i CMakeLists.txt || die "failed to make docs optional"

	kde4-base_src_prepare
}

src_configure() {
	append-cppflags -DQT_THREAD_SUPPORT
	mycmakeargs="${mycmakeargs}
		-DDAILY_BUILD=ON
		-DLIB_INSTALL_DIR=${KDEDIR}/$(get_libdir)
		$(cmake-utils_use_build doc)"

	kde4-base_src_configure
}

src_install() {
	kde4-base_src_install

	# Remove kio svn service types - provided by kdesdk-kioslaves
	rm -f "${D}/${KDEDIR}"/share/kde4/services/svn{,+ssh,+https,+file,+http}.protocol
}

pkg_postinst() {
	if ! has_version 'kde-base/kompare'; then
		echo
		elog "For nice graphical diffs, install kde-base/kompare."
		echo
	fi

	kde4-base_pkg_postinst
}
