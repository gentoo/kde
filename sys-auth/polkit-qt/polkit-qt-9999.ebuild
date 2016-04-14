# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils multibuild git-r3

DESCRIPTION="PolicyKit Qt4 API wrapper library"
HOMEPAGE="http://www.kde.org/"
EGIT_REPO_URI=( "git://anongit.kde.org/polkit-qt-1" )

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug examples +qt4 qt5"

REQUIRED_USE="|| ( qt4 qt5 )"

RDEPEND="
	dev-libs/glib:2
	>=sys-auth/polkit-0.103
	qt4? (
		dev-qt/qtcore:4[glib]
		dev-qt/qtdbus:4
		dev-qt/qtgui:4[glib]
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		examples? ( dev-qt/qtxml:5 )
	)
"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS README README.porting TODO )

pkg_setup() {
	MULTIBUILD_VARIANTS=( $(usev qt4) $(usev qt5) )
}

src_configure() {
	myconfigure() {
		local mycmakeargs=(
			-DSYSCONF_INSTALL_DIR="${EPREFIX}"/etc
			-DBUILD_EXAMPLES=$(usex examples)
		)

		if [[ ${MULTIBUILD_VARIANT} = qt4 ]] ; then
			mycmakeargs+=( -DUSE_QT4=ON )
		fi
		if [[ ${MULTIBUILD_VARIANT} = qt5 ]] ; then
			mycmakeargs+=( -DUSE_QT5=ON )
		fi

		cmake-utils_src_configure
	}

	multibuild_foreach_variant myconfigure
}

src_compile() {
	multibuild_foreach_variant cmake-utils_src_compile
}

src_install() {
	multibuild_foreach_variant cmake-utils_src_install
}
