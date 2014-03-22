# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS="pt_BR"
PYTHON_COMPAT=( python{2_6,2_7} )
inherit kde4-base python-single-r1

EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}"

DESCRIPTION="Graphical application for Portage's daily tasks"
HOMEPAGE="http://gitorious.org/kportagetray"
[[ ${PV} == 9999* ]] || SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="4"
IUSE="debug"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	dev-python/PyQt4[svg,dbus,${PYTHON_USEDEP}]
	$(add_kdebase_dep pykde4 "${PYTHON_USEDEP}")
"
RDEPEND="${DEPEND}
	app-portage/eix
	app-portage/genlop
	$(add_kdebase_dep kdesu)
	$(add_kdebase_dep knotify)
	$(add_kdebase_dep konsole)
"

pkg_setup() {
	python-single-r1_pkg_setup
	kde4-base_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DPYTHONBIN=/usr/bin/python2
	)

	kde4-base_src_configure
}
