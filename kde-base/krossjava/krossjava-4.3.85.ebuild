# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebindings"
KMMODULE="java/krossjava"
inherit java-pkg-2 java-ant-2 kde4-meta eutils

DESCRIPTION="Java plugin for the kdelibs/kross scripting framework."
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	>=virtual/jdk-1.5
"
RDEPEND="
	>=virtual/jre-1.5
"

RESTRICT="test"

PATCHES=( "${FILESDIR}/${PN}-4.2.3_includes.patch" )

src_prepare() {
	find "${S}" -iname '*.jar' | xargs rm -v
	kde4-meta_src_prepare
	java-pkg-2_src_prepare
}

src_configure() {
	mycmakeargs=(-DENABLE_KROSSJAVA=ON)
	kde4-meta_src_configure
	java-ant-2_src_configure
}

src_compile() {
	kde4-meta_src_compile
	cd "${S}/java/${PN}/${PN}/java/" || die
	eant makejar
}

src_install() {
	kde4-meta_src_install
	java-pkg_dojar "${ED}/${KDEDIR}/$(get_libdir)/kde4/kross/kross.jar"

	cd "${ED}${KDEDIR}/$(get_libdir)/kde4/kross/" || die
	local path_prefix="../../../../"

	if [[ ${KDEDIR} != /usr ]]; then
		path_prefix="${path_prefix}../"
	fi

	dosym "${path_prefix}usr/share/${PN}-${SLOT}/lib/kross.jar" \
		"${KDEDIR}/$(get_libdir)/kde4/kross/kross.jar"
	java-pkg_regso "${ED}/${KDEDIR}/$(get_libdir)/kde4/libkrossjava.so"
}
