# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit distutils

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.6"
RESTRICT_PYTHON_ABIS="2.5 3.*"

DESCRIPTION="Extension to sphinx to create links to issue trackers"
HOMEPAGE="http://packages.python.org/sphinxcontrib-issuetracker/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/setuptools
	test? ( dev-python/pyquery )"
RDEPEND=">=dev-python/sphinx-1.0"
