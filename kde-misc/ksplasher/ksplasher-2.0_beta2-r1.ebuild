# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/ksplasher/ksplasher-2.0_beta2.ebuild,v 1.1 2009/11/11 01:05:42 ssuominen Exp $

EAPI=2
PYTHON_DEPEND="2"
inherit python eutils

DESCRIPTION="a KSplashX engine (KDE4) Splash Screen Creator"
HOMEPAGE="http://ksplasher.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}x${PV/_}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/imaging
	dev-python/PyQt4"

S=${WORKDIR}/${PN}x

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	python_convert_shebangs -r 2 .
	# ksplasherx is a bash script which calls 'python foo'. We fix it here.
	sed -i -e 's:python:/usr/bin/env python2:g' ksplasherx || die
}

src_install() {
	dobin ksplasherx || die
	insinto /usr/share/ksplasherx
	doins -r src || die
	doicon ksicon.png
	make_desktop_entry ${PN}x KSplasherX ksicon "Qt;KDE;Graphics"
	dodoc README
}
