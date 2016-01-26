# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="A Qt5-based library for OAuth support"
HOMEPAGE="https://wiki.github.com/ayoy/qoauth"
if [[ ${PV} = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ayoy/qoauth.git"
else
	SRC_URI="http://files.ayoy.net/qoauth/release/${PV}/src/${P}-src.tar.bz2"
	S=${WORKDIR}/${P}-src
fi

LICENSE="LGPL-2.1"
SLOT="5"
KEYWORDS=""
IUSE="debug doc static-libs test"

COMMON_DEPEND="app-crypt/qca:2[debug?,qt5]"
DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen )
	test? ( dev-qt/qttest:5 )
"
RDEPEND="${COMMON_DEPEND}
	app-crypt/qca:2[openssl]
	!dev-libs/qoauth:0
"

DOCS=( README CHANGELOG )

src_prepare() {
	default

	# disable functional tests that require network connection
	# and rely on 3rd party external server (bug #341267)
	epatch "${FILESDIR}/${PN}-1.0.1-disable-ft.patch"

	if ! use test; then
		sed -i -e '/SUBDIRS/s/tests//' ${PN}.pro || die "sed failed"
	fi

	sed -i -e '/^ *docs \\$/d' \
		-e '/^ *build_all \\$/d' \
		-e 's/^\#\(!macx\)/\1/' \
		src/src.pro || die "sed failed"

	sed -i -e "s/\(.*\)lib$/\1$(get_libdir)/" src/pcfile.sh || die "sed failed"
}

src_configure() {
	default
	eqmake5 qoauth.pro
}

src_compile() {
	default
	if use static-libs; then
		emake -C src static
	fi
}

src_install() {
	INSTALL_ROOT="${D}" default

	if use static-libs; then
		dolib.a "${S}"/lib/lib${PN}.a
	fi

	if use doc; then
		doxygen "${S}"/Doxyfile || die "failed to generate documentation"
		dohtml "${S}"/doc/html/*
	fi
}
