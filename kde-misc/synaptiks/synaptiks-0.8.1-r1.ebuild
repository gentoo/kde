# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/synaptiks/synaptiks-0.8.1.ebuild,v 1.5 2012/10/29 16:38:10 mgorny Exp $

EAPI=4
PYTHON_DEPEND="2:2.6"
DISTUTILS_SRC_TEST=setup.py
KDE_HANDBOOK=optional
inherit kde4-base distutils

DESCRIPTION="Touchpad configuration and management tool for KDE"
HOMEPAGE="http://synaptiks.readthedocs.org"
SRC_URI="mirror://pypi/s/${PN}/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc +upower"

RDEPEND=">=dev-python/PyQt4-4.7
	>=dev-python/pyudev-0.8[pyqt4]
	dev-python/setuptools
	$(add_kdebase_dep pykde4)
	|| (
		( $(add_kdebase_dep kdesdk-scripts) )
		( $(add_kdebase_dep kde-dev-scripts) )
	)
	virtual/python-argparse
	>=x11-drivers/xf86-input-synaptics-1.3
	>=x11-libs/libXi-1.4
	x11-libs/libXtst
	upower? ( dev-python/dbus-python sys-power/upower )"
DEPEND="${RDEPEND}
	app-text/docbook-xsl-stylesheets
	sys-devel/gettext
	doc? (
		dev-python/sphinx
		dev-python/sphinxcontrib-issuetracker
	)"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	if use doc; then
		epatch "${FILESDIR}/${P}-templatesfix.patch"
	fi
}

src_configure() {
	:;
}

src_compile() {
	distutils_src_compile
	if use doc; then
		einfo "Generation of documentation"
		pushd doc > /dev/null
		sphinx-build . _build
		popd > /dev/null
	fi
}

src_install() {
	distutils_src_install
	if use doc; then
		dohtml -r doc/_build/*
	fi
}
