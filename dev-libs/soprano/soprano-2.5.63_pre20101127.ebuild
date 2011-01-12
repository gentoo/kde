# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit cmake-utils flag-o-matic

DESCRIPTION="Library that provides a nice Qt interface to RDF storage solutions"
HOMEPAGE="http://sourceforge.net/projects/soprano"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="LGPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="clucene +dbus debug doc elibc_FreeBSD +raptor +redland test +virtuoso"

RESTRICT="test"

COMMON_DEPEND="
	>=x11-libs/qt-core-4.5.0:4
	clucene? ( dev-cpp/clucene )
	dbus? ( >=x11-libs/qt-dbus-4.5.0:4 )
	raptor? ( >=media-libs/raptor-1.4.16 )
	redland? (
		>=dev-libs/rasqal-0.9.15
		>=dev-libs/redland-1.0.10
	)
	virtuoso? ( dev-db/libiodbc:0 )
"
DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen )
	test? ( >=x11-libs/qt-test-4.5.0:4 )
"
RDEPEND="${COMMON_DEPEND}
	virtuoso? ( >=dev-db/virtuoso-server-6.1.0 )
"

CMAKE_IN_SOURCE_BUILD="1"

PATCHES=(
	"${FILESDIR}/${PN}-2.4.4-make-broken-redland-fatal.cmake"
)

pkg_setup() {
	if [[ ${PV} = *9999* && -z $I_KNOW_WHAT_I_AM_DOING ]]; then
		echo
		ewarn "WARNING! This is an experimental ebuild of ${PN} SVN tree. Use at your own risk."
		ewarn "Do _NOT_ file bugs at bugs.gentoo.org because of this ebuild!"
		echo
	fi

	if ! use virtuoso; then
		echo
		ewarn "You have explicitly disabled the default soprano backend."
		ewarn "Applications using soprano may need at least one backend"
		ewarn "to be functional. If you experience any problems, enable"
		ewarn "the virtuoso USE flag."
		echo
	fi
}

src_configure() {
	# Fix for missing pthread.h linking
	# NOTE: temporarily fix until a better cmake files patch will be provided.
	use elibc_FreeBSD && append-flags -pthread

	mycmakeargs=(
		-DSOPRANO_BUILD_TESTS=OFF
		-DCMAKE_SKIP_RPATH=OFF
		-DSOPRANO_DISABLE_SESAME2_BACKEND=ON
		$(cmake-utils_use !clucene SOPRANO_DISABLE_CLUCENE_INDEX)
		$(cmake-utils_use !dbus SOPRANO_DISABLE_DBUS)
		$(cmake-utils_use !raptor SOPRANO_DISABLE_RAPTOR_PARSER)
		$(cmake-utils_use !redland SOPRANO_DISABLE_RAPTOR_SERIALIZER)
		$(cmake-utils_use !redland SOPRANO_DISABLE_REDLAND_BACKEND)
		$(cmake-utils_use !virtuoso SOPRANO_DISABLE_VIRTUOSO_BACKEND)
		$(cmake-utils_use doc SOPRANO_BUILD_API_DOCS)
		$(cmake-utils_use test SOPRANO_BUILD_TESTS)
	)

	cmake-utils_src_configure
}
