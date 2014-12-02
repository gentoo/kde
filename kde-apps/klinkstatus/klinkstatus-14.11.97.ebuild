# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdewebdev"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="KDE web development - link validity checker"
HOMEPAGE="http://www.kde.org/applications/development/klinkstatus/"
KEYWORDS=" ~amd64 ~x86"
IUSE="debug tidy"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	tidy? ( app-text/htmltidy )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DWITH_KdepimLibs=ON
		$(cmake-utils_use_with tidy LibTidy)
	)

	kde4-meta_src_configure
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	if ! has_version dev-lang/ruby ; then
		elog "To use scripting in ${PN}, install dev-lang/ruby."
	fi
}
