# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit git perl-module qt4 cmake-utils

DESCRIPTION="Source code sanity checker for KDE developers."
HOMEPAGE="http://www.kde.org/"
EGIT_REPO_URI="git://gitorious.org/krazy/krazy.git"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

DEPEND="
	>=dev-perl/HTML-Parser-2.20
	>=dev-perl/Tie-IxHash-1.20
	>=dev-perl/XML-LibXML-1.57
	dev-perl/yaml
	>=x11-libs/qt-gui-4.4:4
"
RDEPEND="${DEPEND}
	dev-util/desktop-file-utils
"

CMAKE_USE_DIR="${S}/cppchecks"

src_unpack() {
	git_src_unpack
}

src_prepare() {
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
