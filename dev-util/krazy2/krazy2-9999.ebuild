# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit perl-module subversion qt4 cmake-utils

DESCRIPTION="Source code sanity checker for KDE developers."
HOMEPAGE="http://www.kde.org/"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/quality/krazy2"
ESVN_UP_FREQ=${ESVN_UP_FREQ:-1}

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

DEPEND="
	>=dev-perl/HTML-Parser-2.20
	>=dev-perl/Tie-IxHash-1.20
	>=dev-perl/XML-LibXML-1.57
	>=x11-libs/qt-gui-4.4:4
"
RDEPEND="${DEPEND}
	dev-util/desktop-file-utils
"

#PATCHES=( "${FILESDIR}/install.sh.patch"
#			"${FILESDIR}/multilib.patch" )

CMAKE_USE_DIR="${S}/cppchecks"

src_unpack() {
	subversion_src_unpack
}

src_prepare() {
	epatch "${FILESDIR}/install.sh.patch"
	epatch "${FILESDIR}/multilib.patch"

	sed -i -e 's/+= ordered/+= ordered nostrip/' \
		src/src.pro || die "failed to apply nostrip"

	sed -i "s:$TOP/lib:$TOP/$(get_libdir):" install.sh || die "sed failed"

	sed -i "s:lib\$(LIBSUFFIX):$(get_libdir):" src/passbyvalue/passbyvalue.pro || die "sed failed"

	base_src_prepare
}

src_configure() {
	cmake-utils_src_configure
	cd src
	eqmake4 src.pro
}

src_compile() {
	cmake-utils_src_compile
	cd src
	emake "$@" || die "2nd Make failed!"
}

src_install() {
	dodoc README TODO || die "dodoc failed"

	cmake-utils_src_install

	cd src
	emake install INSTALL_ROOT="${D}/usr" || die "Make src install failed"
	cd ..

	./install.sh "${D}/usr" || die "install failed"
}
