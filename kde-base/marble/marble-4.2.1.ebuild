# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/marble/marble-4.2.0.ebuild,v 1.2 2009/02/01 08:29:33 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdeedu"
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="Generic geographical map widget"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug designer-plugin htmlhandbook +kde gps plasma python"

DEPEND="
	gps? ( sci-geosciences/gpsd )
	kde? (
		>=kde-base/kdelibs-${PV}:${SLOT}[kdeprefix=]
		>=kde-base/kdepimlibs-${PV}:${SLOT}[kdeprefix=]
	)
	python? (
		>=dev-python/PyQt4-4.4.4-r1
		kde? ( >=kde-base/pykde4-${PV}:${SLOT} )
	)
"
RDEPEND="${DEPEND}
	!kdeprefix? ( !sci-geosciences/marble )
"

pkg_setup() {
	if use plasma && ! use kde; then
		echo
		eerror "KDE integration is required to build marble world clock applet."
		eerror
		eerror "Either enable 'kde' USE flag or disable 'plasma'."
		eerror "You can do this by setting these flags in /etc/portage/package.use, like:"
		eerror "    =${CATEGORY}/${PN}-${PV} kde plasma"
		echo
		die "Conflicting USE flags found"
	fi

	kde4-meta_pkg_setup
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with designer-plugin DESIGNER_PLUGIN)
		$(cmake-utils_use_with plasma Plasma)
		$(cmake-utils_use_with python PyQt4)
		$(cmake-utils_use_with python PythonLibrary)
		$(cmake-utils_use_with python SIP)"

	sed -i -e 's:add_subdirectory(cmake):#dontwantit:g' CMakeLists.txt \
		|| die "sed to disable file collisions failed"

	find "${S}/marble/src/bindings/python/sip" -name "*.sip" | xargs -- sed -i 's/#include <marble\//#include </'

	if use gps; then
		mycmakeargs="${mycmakeargs} -DHAVE_LIBGPS=1"
	else
		sed -i -e 's:FIND_LIBRARY(libgps_LIBRARIES gps):# LIBGPS DISABLED &:' \
			marble/Findlibgps.cmake || die "sed to disable gpsd failed."
	fi

	if use kde; then
		mycmakeargs="${mycmakeargs} $(cmake-utils_use_with python PyKDE4)"
	else
		mycmakeargs="${mycmakeargs} -DQTONLY=ON -DWITH_PyKDE4=OFF"
	fi

	kde4-meta_src_configure
}
