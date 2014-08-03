# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit perl-module qt4-r2 cmake-utils multilib git-r3

DESCRIPTION="Source code sanity checker for KDE developers"
HOMEPAGE="http://www.kde.org/"
EGIT_REPO_URI=( "git://gitorious.org/krazy/krazy.git" )

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="cxx debug"

DEPEND="
	>=dev-perl/HTML-Parser-2.20
	>=dev-perl/Tie-IxHash-1.20
	>=dev-perl/XML-LibXML-1.57
	dev-perl/yaml
	>=dev-qt/qtcore-4.4:4
	>=dev-qt/qtgui-4.4:4
"
RDEPEND="${DEPEND}
	dev-util/desktop-file-utils
	virtual/perl-ExtUtils-MakeMaker
"

CMAKE_USE_DIR="${S}/cppchecks"

PATCHES=( "${FILESDIR}/${P}-libs.patch" )

src_prepare() {
	sed -i -e 's/+= ordered/+= ordered nostrip/' \
		src/src.pro || die "failed to apply nostrip"

	sed -i "s:lib\$(LIBSUFFIX):$(get_libdir):" src/passbyvalue/passbyvalue.pro || die "sed failed"

	base_src_prepare
}

src_configure() {
	use cxx && cmake-utils_src_configure
	perl-module_src_configure
	eqmake4 src/src.pro
}

src_compile() {
	use cxx && cmake-utils_src_compile
	perl-module_src_compile
	emake -C src
}

src_install() {
	dodoc README TODO

	use cxx && cmake-utils_src_install

	perl-module_src_install

	emake -C src install INSTALL_ROOT="${D}/usr"
	emake -C extras install PREFIX="${D}/usr"
	emake -C helpers install PREFIX="${D}/usr"
	emake -C sets install PREFIX="${D}/usr"
	emake -C plugins install DESTDIR="${D}/usr"

	insinto /usr/share/dtd
	doins share/*.*

	insinto /usr/share/xsl
	doins stylesheets/*.*
}
