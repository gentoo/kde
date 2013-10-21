# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
KDE_REQUIRED="optional"
KDE_SCM="svn"

inherit kde4-base

if [[ $PV != *9999 ]]; then
	REV="1688"
	S="${WORKDIR}/cloudcity-code-${REV}"
	SRC_URI="http://sourceforge.net/code-snapshots/svn/c/cl/cloudcity/code/cloudcity-code-${REV}.zip"
	KEYWORDS="~amd64 ~x86"
else
	ESVN_REPO_URI="https://cloudcity.svn.sourceforge.net/svnroot/cloudcity"
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
	mycmakeargs=(
		$(cmake-utils_use_enable kde KDE)
		$(cmake-utils_use_enable windeco KWIN)
		$(cmake-utils_use_enable plasma XBAR)
		-DENABLE_ARGB=ON
	)

	kde4-base_src_configure
}
