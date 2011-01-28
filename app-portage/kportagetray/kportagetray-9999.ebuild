# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

SCM=""
if [ "${PV%9999}" != "${PV}" ] ; then
	SCM=git
	EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}.git"
fi

KDE_LINGUAS="pt_BR"
PYTHON_DEPEND="2:2.6"

inherit ${SCM} kde4-base python

DESCRIPTION="Graphical application for Portage's daily tasks"
HOMEPAGE="http://gitorious.org/kportagetray"

if [ "${PV%9999}" != "${PV}" ] ; then # Live ebuild
	SRC_URI=""
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
fi

LICENSE="GPL-3"
KEYWORDS=""
SLOT="4"
IUSE=""

DEPEND="
	dev-python/PyQt4[svg,dbus]
	>=kde-base/pykde4-${KDE_MINIMAL}
"
RDEPEND="${DEPEND}
	app-portage/eix
	app-portage/genlop
	>=kde-base/kdesu-${KDE_MINIMAL}
	>=kde-base/knotify-${KDE_MINIMAL}
	>=kde-base/konsole-${KDE_MINIMAL}
"

pkg_setup() {
	python_set_active_version 2
	kde4-base_pkg_setup
}

src_unpack() {
	if [ "${PV%9999}" != "${PV}" ] ; then
		git_src_unpack
	else
		base_src_unpack
	fi
}

src_prepare() {
	python_convert_shebangs -r 2 .
	kde4-base_src_prepare
}

pkg_postinst() {
	kde4-base_pkg_postinst
}
