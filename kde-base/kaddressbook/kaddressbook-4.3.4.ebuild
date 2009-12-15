# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="The KDE Address Book"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug +handbook gnokii"

DEPEND="
	$(add_kdebase_dep libkdepim)
	$(add_kdebase_dep libkleo)
	gnokii? ( app-mobilephone/gnokii )
"
RDEPEND="${DEPEND}"

KMEXTRA="
	plugins/ktexteditor/
"
# xml targets from kmail are being uncommented by kde4-meta.eclass
KMEXTRACTONLY="
	kmail/
	libkleo/
"
KMLOADLIBS="libkdepim libkleo"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with gnokii)
	)

	kde4-meta_src_configure
}

src_install() {
	kde4-meta_src_install

	# install additional generated header that is needed by kresources
	insinto "${KDEDIR}"/include/${PN}
	doins "${CMAKE_BUILD_DIR}"/${PN}/common/kabprefs_base.h || \
		die "Failed to install extra header files"
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	if ! has_version kde-base/kdepim-kresources:${SLOT}; then
		echo
		elog "For groupware functionality, please install kde-base/kdepim-kresources:${SLOT}"
		echo
	fi
}
