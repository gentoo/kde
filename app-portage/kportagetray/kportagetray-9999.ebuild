# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="pt_BR"
NEED_PYTHON="2.6"

inherit git kde4-base python

DESCRIPTION="A set of basic operations for Portage"
HOMEPAGE="http://gitorious.org/kportagetray"
EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}.git"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="4"
IUSE=""

DEPEND="
	!kde-misc/kportagetray
	dev-python/PyQt4[svg,dbus]
	>=kde-base/pykde4-${KDE_MINIMAL}
"
RDEPEND="${DEPEND}
	app-portage/eix
	>=kde-base/kdesu-${KDE_MINIMAL}
	>=kde-base/knotify-${KDE_MINIMAL}
	>=kde-base/konsole-${KDE_MINIMAL}
"

src_unpack() {
	git_src_unpack
}

pkg_postinst() {
	kde4-base_pkg_postinst
}
