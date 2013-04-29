# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop-python/kdevelop-python-1.4.1.ebuild,v 1.2 2012/12/12 12:26:18 dastergon Exp $

EAPI=5

KDE_SCM="git"
EGIT_BRANCH="1.5"
KMNAME="kdev-python"
KDEVPLATFORM_VERSION="1.4.60"
PYTHON_DEPEND="2"

inherit kde4-base python

MY_PN="kdev-python"
MY_PV="v${PV}"
MY_P="${MY_PN}-${MY_PV}"

if [[ $PV != *9999* ]]; then
	SRC_URI="mirror://kde/stable/kdevelop/${MY_PN}/${PV}/src/${MY_P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${MY_P}
else
	EGIT_REPO_URI="git://anongit.kde.org/kdev-python.git"
	KEYWORDS=""
fi

DESCRIPTION="Python plugin for KDevelop 4"
HOMEPAGE="http://www.kdevelop.org"

LICENSE="GPL-2"
SLOT="4"
IUSE="debug"

DEPEND="
	>=dev-util/kdevelop-pg-qt-1.0.0
	>=dev-util/kdevplatform-1.4.60
	dev-util/kdevelop
"
RDEPEND="${DEPEND}"

RESTRICT="test"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup

	kde4-base_pkg_setup
}

src_compile() {
	pushd "${WORKDIR}"/${P}_build
	emake parser
	popd

	kde4-base_src_compile
}
