# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdesdk
KMMODULE=kioslave
inherit kde4svn-meta

DESCRIPTION="kioslaves from kdesdk package: the subversion kioslave"
KEYWORDS=""
IUSE="debug"

DEPEND="dev-libs/apr
		dev-util/subversion"
RDEPEND="${RDEPEND}"

pkg_setup() {
	if ldd /usr/bin/svn | grep -q libapr-0 \
		&& ! has_version dev-libs/apr:0;
	then
		eerror "Subversion has been built against dev-libs/apr:0, but no matching version is installed."
		die "Please rebuild dev-util/subversion."
	fi
	if ldd /usr/bin/svn | grep -q libapr-1 \
		&& ! has_version dev-libs/apr:1;
	then
		eerror "Subversion has been built against dev-libs/apr:1, but no matching version is installed."
		die "Please rebuild dev-util/subversion."
	fi
}

src_compile() {
	if ldd /usr/bin/svn | grep -q libapr-0; then
		mycmakeargs="${mycmakeargs} -DAPRCONFIG_EXECUTABLE=/usr/bin/apr-config"
	else
		mycmakeargs="${mycmakeargs} -DAPRCONFIG_EXECUTABLE=/usr/bin/apr-1-config"
	fi

	kde4overlay-meta_src_compile
}

src_install() {
	kde4overlay-meta_src_install
	if has_version 'dev-util/kdesvn'; then
		rm "${D}"/usr/kde/svn/share/kde4/services/svn.protocol
		rm "${D}"/usr/kde/svn/share/kde4/services/svn+ssh.protocol
		rm "${D}"/usr/kde/svn/share/kde4/services/svn+https.protocol
		rm "${D}"/usr/kde/svn/share/kde4/services/svn+file.protocol
		rm "${D}"/usr/kde/svn/share/kde4/services/svn+http.protocol
	fi
}
