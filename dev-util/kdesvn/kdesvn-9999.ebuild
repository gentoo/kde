# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"

inherit kde4svn base eutils toolchain-funcs

# Install to KDEDIR rather than /usr, to slot properly.
PREFIX="${KDEDIR}"

DESCRIPTION="KDESvn is a frontend to the subversion vcs."
HOMEPAGE="http://www.alwins-world.de/wiki/programs/kdesvn"
ESVN_REPO_URI="http://www.alwins-world.de/repos/kdesvn/trunk/"
ESVN_PROJECT="kdesvn"

SLOT="kde-svn"
LICENSE="GPL-2"
KEYWORDS=""
IUSE="debug sqlite"

RDEPEND=">=dev-util/subversion-1.4
	sqlite? ( dev-db/sqlite )"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4"

src_unpack() {
	kde4svn_src_unpack
}

src_compile() {
	local myconf
	if use debug ; then
		myconf="-DCMAKE_BUILD_TYPE=Debug"
	fi

	cmake \
		-DCMAKE_INSTALL_PREFIX=${PREFIX} \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_C_COMPILER=$(type -P $(tc-getCC)) \
		-DCMAKE_CXX_COMPILER=$(type -P $(tc-getCXX)) \
		-DCMAKE_CXX_FLAGS="${CXXFLAGS} -DQT_THREAD_SUPPORT" \
		-DLIB_INSTALL_DIR=/usr/$(get_libdir) \
		${myconf} || die

	emake || die
}

src_install() {
	cmake-utils_src_install
	if has_version 'kde-base/kdesdk-kioslaves'; then
		rm "${D}"/usr/kde/svn/share/kde4/services/svn.protocol
		rm "${D}"/usr/kde/svn/share/kde4/services/svn+ssh.protocol
		rm "${D}"/usr/kde/svn/share/kde4/services/svn+https.protocol
		rm "${D}"/usr/kde/svn/share/kde4/services/svn+file.protocol
		rm "${D}"/usr/kde/svn/share/kde4/services/svn+http.protocol
	fi
}

pkg_postinst() {
	if ! has_version 'kde-base/kompare'; then
		echo
		elog "For nice graphical diffs, install kde-base/kompare."
		echo
	fi
}

