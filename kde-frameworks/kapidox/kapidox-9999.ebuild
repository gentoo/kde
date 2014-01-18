# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_DEBUG="false"
FRAMEWORKS_DOXYGEN="false"
FRAMEWORKS_TEST="false"
PYTHON_COMPAT=( python{2_7,3_3} )
inherit kde-frameworks python-single-r1

DESCRIPTION="Framework for building KDE API documentation in a standard format and style"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS=""
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	app-doc/doxygen
	dev-python/pystache[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	${PYTHON_DEPS}
"

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	insinto /usr/share/${PN}
	doins src/*.local src/*.sh src/*.py

	python_fix_shebang "${D}"/usr/share/${PN}

	fperms +x /usr/share/${PN}/{doxygen-preprocess-kcfg.sh,kgenapidox.py,kgenframeworksapidox.py}

	docompress -x /usr/share/doc/HTML/en/common
	insinto /usr/share/doc/HTML/en/common
	doins common/{*.html,dependencies.md,Doxyfile.global,doxygen.css}
	doins -r common/htmlresource
}
