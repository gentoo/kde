# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
inherit kde4svn

DESCRIPTION="Integrated Development Environment for Unix, supporting KDE/Qt, C/C++ and many other languages."
HOMEPAGE="http://www.kde.org/"

SLOT="kde-svn"

KEYWORDS=""
IUSE="cmake +cxx debug qmake"
LICENSE="GPL-2 LGPL-2"

# Slot package
PREFIX="${KDEDIR}"

DEPEND="kde-base/kdevplatform:${SLOT}
	sys-devel/gdb
	=sys-libs/db-4*
	media-gfx/graphviz
	cmake? ( dev-util/cmake )"
RDEPEND=""

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DBUILD_cmake=$(useq cmake && echo On || echo Off)
		-DBUILD_cmakebuilder=$(useq cmake && echo On || echo Off)
		-DBUILD_qmake=$(useq qmake && echo On || echo Off)
		-DBUILD_qmakebuilder=$(useq qmake && echo On || echo Off)
		-DBUILD_cpp=$(useq cxx && echo On || echo Off)"

	kde4overlay-base_src_compile
}

src_install() {
	kde4overlay-base_src_install
	if has_version 'kde-base/kapptemplate'; then
		rm "${D}"/usr/kde/svn/share/apps/kdevappwizard/templates/qmake_qt4guiapp.tar.bz2
	fi
}

pkg_postinst() {
	elog "kdevelop can use a wide range of apps for extra functionality. This is an almost"
	elog "complete list. All these packages can be emerged after kdevelop."
	elog
	elog "kde-base/kdebase:		(RECOMMENDED) embed konsole kpart in kdevelop ide"
	elog "dev-util/kdbg:		(RECOMMENDED) kde frontend to gdb"
	elog "dev-util/valgrind:	(RECOMMENDED) integrates valgrind (memory debugger) commands"
	elog "kde-base/kompare:		(RECOMMENDED) show differences between files"
	echo
	elog "dev-java/ant:			support projects using the ant build tool"
	elog "dev-util/ctags:		faster and more powerful code browsing logic"
	elog "app-doc/doxygen:		generate KDE-style documentation for your project"
	elog "www-misc/htdig:		index and search your project's documentation"
	elog "app-arch/rpm:			support creating RPMs of your project"
	elog "app-emulation/visualboyadvance:"
	elog "						create and run projects for this gameboy"
	elog
	elog "Support for GNU-style make, tmake, qmake is included."
	elog "Support for using clearcase, perforce and subversion"
	elog "as version control systems is optional."

	kde4overlay-base_pkg_postinst
}
