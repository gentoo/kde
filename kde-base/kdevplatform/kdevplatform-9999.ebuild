# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
inherit kde4svn

DESCRIPTION="KDE development support libraries and apps"
HOMEPAGE="http://www.kde.org/"

KEYWORDS=""
IUSE="debug htmlhandbook subversion"
LICENSE="GPL-2 LGPL-2"

# FIXME: Add || ( ) deps when splits are ready
#kde-base/kdesdk:${SLOT} is that really needed?
DEPEND="
	subversion? ( >=dev-util/subversion-1.3 )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use subversion ; then
		if [[ -n "$(ldd /usr/bin/svn | grep -o libapr-0)" ]] \
			&& ! has_version =dev-libs/apr-0* ;
		then
			eerror "Subversion has been built against =dev-libs/apr-0*, but no matching version is installed."
			die "Please rebuild dev-util/subversion."
		fi
		if [[ -n "$(ldd /usr/bin/svn | grep -o libapr-1)" ]] \
			&& ! has_version =dev-libs/apr-1* ;
		then
			eerror "Subversion has been built against =dev-libs/apr-1*, but no matching version is installed."
			die "Please rebuild dev-util/subversion."
		fi
	fi

}

src_compile() {
	if use subversion; then
		if [[ -n "$(ldd /usr/bin/svn | grep -o libapr-0)" ]] ; then
			mycmakeargs="${mycmakeargs} -DAPRCONFIG_EXECUTABLE=/usr/bin/apr-config"
		else
			mycmakeargs="${mycmakeargs} -DAPRCONFIG_EXECUTABLE=/usr/bin/apr-1-config"
		fi
	fi

	kde4overlay-base_src_compile
}
