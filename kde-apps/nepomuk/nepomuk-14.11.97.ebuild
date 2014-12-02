# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="Nepomuk KDE4 client"
HOMEPAGE+=" http://userbase.kde.org/Nepomuk"
KEYWORDS=" ~amd64 ~x86"
IUSE="debug"

DEPEND="
	>=dev-libs/soprano-2.9.0[dbus,raptor,redland,virtuoso]
	$(add_kdebase_dep kdelibs 'nepomuk')
	$(add_kdebase_dep nepomuk-core)
	!kde-misc/nepomukcontroller
"
RDEPEND="${DEPEND}"

src_prepare() {
	kde4-meta_src_prepare

	# Collides with baloo
	pushd nepomuk/kioslaves > /dev/null
	comment_add_subdirectory timeline
}

src_configure() {
	local mycmakeargs=(
		-DKDERUNTIME_BUILD_NEPOMUK=true
	)

	kde4-meta_src_configure
}
