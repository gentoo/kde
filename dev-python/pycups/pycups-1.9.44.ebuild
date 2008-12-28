# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycups/pycups-1.9.12.ebuild,v 1.1 2006/09/05 21:31:34 dberkholz Exp $

inherit python

DESCRIPTION="Python bindings for the CUPS API"
HOMEPAGE="http://cyberelk.net/tim/data/pycups/"
SRC_URI="http://cyberelk.net/tim/data/pycups/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""

src_compile() {
	python_version
	emake PYTHONVERS="python${PYVER}" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
