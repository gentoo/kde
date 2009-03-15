# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit perl-module subversion qt4 cmake-utils

DESCRIPTION="Source code sanity checker for KDE developers."
HOMEPAGE="http://www.kde.org/"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/quality/krazy2"
ESVN_UP_FREQ=${ESVN_UP_FREQ:-1}

IUSE=""
KEYWORDS=""
LICENSE="GPL-2"
SLOT="live"

DEPEND="
	>=dev-perl/HTML-Parser-2.20
	>=dev-perl/Tie-IxHash-1.20
	>=dev-perl/XML-LibXML-1.57
	|| (
		x11-libs/qt-gui:4
		=x11-libs/qt-4.3*:4
	)
"
RDEPEND="${DEPEND}
	dev-util/desktop-file-utils
"

PATCHES=( "${FILESDIR}/install.sh.patch" )
CMAKE_IN_SOURCE_BUILD=1

src_prepare() {
	sed -i -e 's/+= ordered/+= ordered nostrip/' \
		src/src.pro || die "failed to apply nostrip"
	base_src_prepare
}

src_configure() {
	cd cppchecks
	cmake-utils_src_configure
	cd ../src
	eqmake4 src.pro
	cd ..
}

src_compile() {
	cd cppchecks
	emake "$@" || die "Make failed!"
	cd ../src
	emake "$@" || die "Make failed!"
	cd ..
}

src_install() {
	dodoc README TODO || die "dodoc failed"


	cd cppchecks
	emake install DESTDIR="${D}" || die "Make cppchecks install failed"
	cd ../src
	emake install INSTALL_ROOT="${D}/usr" || die "Make src install failed"
	cd ..

	./install.sh "${D}/usr" || die "install failed"
}
