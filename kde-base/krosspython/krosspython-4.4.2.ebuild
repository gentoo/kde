# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krosspython/krosspython-4.4.2.ebuild,v 1.1 2010/03/30 21:29:32 spatz Exp $

EAPI="3"

KMNAME="kdebindings"
KMMODULE="python/krosspython"
PYTHON_DEPEND="2"
inherit python kde4-meta

DESCRIPTION="Kross scripting framework: Python interpreter"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	kde4-meta_pkg_setup
}
