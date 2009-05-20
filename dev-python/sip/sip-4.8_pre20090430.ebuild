# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
NEED_PYTHON=2.3
inherit python toolchain-funcs versionator multilib

MY_P=${P/_pre/-snapshot-}

DESCRIPTION="A tool for generating bindings for C++ classes so that they can be used by Python"
HOMEPAGE="http://www.riverbankcomputing.co.uk/software/sip/intro"
SRC_URI="http://www.riverbankcomputing.com/static/Downloads/sip$(get_major_version)/${MY_P}.tar.gz"

LICENSE="sip"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug"

S=${WORKDIR}/${MY_P}

DEPEND=""
RDEPEND=""

src_configure(){
	python_version

	local myconf
	use debug && myconf="${myconf} -u"

	"${python}" configure.py \
		-b "/usr/bin" \
		-d "/usr/$(get_libdir)/python${PYVER}/site-packages" \
		-e "/usr/include/python${PYVER}" \
		-v "/usr/share/sip" \
		${myconf} \
		CXXFLAGS_RELEASE="" CFLAGS_RELEASE="" LFLAGS_RELEASE="" \
		CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LFLAGS="${LDFLAGS}" \
		CC=$(tc-getCC) CXX=$(tc-getCXX) \
		LINK=$(tc-getCXX) LINK_SHLIB=$(tc-getCXX) \
		STRIP="true" || die "configure failed"
}

src_install() {
	python_need_rebuild
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog NEWS README TODO doc/sipref.txt
	dohtml doc/*
}

pkg_postinst() {
	python_version
	python_mod_compile "$(python_get_sitedir)"/sip*.py
}

pkg_postrm() {
	python_mod_cleanup
}
