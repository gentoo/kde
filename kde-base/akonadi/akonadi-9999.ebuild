# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

if [[ ${PV} = *9999* ]]; then
	KMNAME="kdepim"
	eclass="kde4-meta"
else
	KMNAME="kdepim-runtime"
	eclass="kde4-base"
fi
inherit ${eclass}

DESCRIPTION="An extensible cross-desktop storage service for PIM data and meta data"
KEYWORDS=""
# add when libmapi becomes available with an ebuild
#exchange
IUSE="debug +semantic-desktop"

# add when libmapi becomes available with an ebuild
#exchange? ( net-libs/libmapi )
DEPEND="
	dev-libs/boost
	dev-libs/libxml2
	dev-libs/libxslt
	$(add_kdebase_dep kdelibs 'semantic-desktop?')
	$(add_kdebase_dep kdepimlibs)
	x11-misc/shared-mime-info
"
RDEPEND="${DEPEND}
	>=app-office/akonadi-server-1.2.1
"

# @since 4.3 - blocks kdemaildir - no longer provided (it's in akonadi now)
add_blocker kdemaildir
add_blocker kdepim-kresources '<4.2.95'

[[ ${KMNAME} = "kdepim-runtime" ]] && S="${WORKDIR}/${KMNAME}-${PV}"

src_prepare() {
	local pref="${S}"
	[[ ${KMNAME} != "kdepim-runtime" ]] && pref="${S}/${PN}"
	if ! use semantic-desktop; then
		sed -i -e "s/add_subdirectory( nepomuktag )//"\
			"${pref}"/resources/CMakeLists.txt\
			|| die "Failed to disable nepomuktag"
	fi

	${eclass}_src_prepare
}

src_configure() {
	mycmakeargs=(
		# Set the dbus dirs, otherwise it searches in KDEDIR
		-DAKONADI_DBUS_INTERFACES_INSTALL_DIR=/usr/share/dbus-1/interfaces
		-DAKONADI_DBUS_SERVICES_INSTALL_DIR=/usr/share/dbus-1/services

		-DWITH_LibXslt=ON
		# replace with $(cmake-utils_use_with exchange OpenChange) when libmapi becomes available with an ebuild
		-DWITH_OpenChange=OFF
		-DWITH_GNOKII=OFF
		-DWITH_GLIB2=OFF
		-DWITH_OpenSync=OFF
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
	)

	${eclass}_src_configure
}

src_test() {
	# disable broken tests
	sed -i -e '/kcalserializertest/ s/^/#DO_NOT_RUN_TEST /' \
		"${S}"/plugins/tests/CMakeLists.txt || \
		die "sed to disable kcalserializertest failed."
	sed -i -e '/kresmigrationtest/ s/^/#DO_NOT_RUN_TEST /' \
		"${S}"/migration/kres/tests/CMakeLists.txt || \
		die "sed to disable kresmigrationtest failed."

	${eclass}_src_test
}

src_install() {
	${eclass}_src_install
	# colliding files with nepomuk
	rm -rf "${D}"/${KDEDIR}/share/apps/nepomuk/ontologies/n{m,c}o.{desktop,trig}
}
