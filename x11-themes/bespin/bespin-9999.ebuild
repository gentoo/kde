# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
KDE_REQUIRED="optional"
KDE_SCM="svn"

inherit kde4-base qmake-utils

if [[ $PV != *9999 ]]; then
	REV="1669"
	S="${WORKDIR}/cloudcity-code-${REV}"
	SRC_URI="http://sourceforge.net/code-snapshots/svn/c/cl/cloudcity/code/cloudcity-code-${REV}.zip"
	KEYWORDS="~amd64 ~x86"
else
	ESVN_REPO_URI="http://svn.code.sf.net/p/cloudcity/code/"
	KEYWORDS=""
fi

DESCRIPTION="Very configurable Qt4/KDE4 style derived from the Oxygen project."
HOMEPAGE="http://cloudcity.sourceforge.net/"

LICENSE="GPL-2"
SLOT="4"
IUSE="debug kde plasma windeco"

REQUIRED_USE="
	windeco? ( kde )
	plasma? ( kde )
"

DEPEND="
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	windeco? ( $(add_kdebase_dep kwin) )
	plasma? ( $(add_kdebase_dep kdelibs) dev-qt/qtgui:4[dbus(+)] )
"

src_configure() {
	if use kde ; then
		local mycmakeargs=(
			$(cmake-utils_use_enable kde KDE)
			$(cmake-utils_use_enable windeco KWIN)
			$(cmake-utils_use_enable plasma XBAR)
			-DENABLE_ARGB=ON
		)

		kde4-base_src_configure
	else
		eqmake4
	fi
}

src_compile() {
	if use kde ; then
		kde4-base_src_compile
	else
		default
	fi
}

src_install() {
	if use kde ; then
		kde4-base_src_install
	else
		emake INSTALL_ROOT="${D}" install
	fi
}
