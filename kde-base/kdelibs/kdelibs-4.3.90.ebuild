# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

CPPUNIT_REQUIRED="optional"
OPENGL_REQUIRED="optional"
WEBKIT_REQUIRED="always"
inherit kde4-base fdo-mime

DESCRIPTION="KDE libraries needed by all KDE programs."
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
LICENSE="LGPL-2.1"
IUSE="3dnow acl alsa altivec bindist +bzip2 debug doc fam +handbook jpeg2k kerberos
lzma mmx nls openexr policykit semantic-desktop spell sse sse2 ssl zeroconf"

# needs the kate regression testsuite from svn
RESTRICT="test"

COMMONDEPEND="
	app-crypt/qca:2
	>=app-misc/strigi-0.6.3
	dev-libs/libattica
	dev-libs/libpcre[unicode]
	dev-libs/libxml2
	dev-libs/libxslt
	>=kde-base/automoc-0.9.87
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/giflib
	media-libs/jpeg:0
	media-libs/libpng
	sys-libs/zlib
	>=x11-misc/shared-mime-info-0.60
	acl? ( virtual/acl )
	alsa? ( media-libs/alsa-lib )
	aqua? (
		>=media-sound/phonon-4.3.80
		sys-apps/dbus
	)
	!aqua? (
		>=media-sound/phonon-4.3.80[xcb]
		sys-apps/dbus[X]
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXcursor
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXft
		x11-libs/libXpm
		x11-libs/libXrender
		x11-libs/libXtst
		!kernel_SunOS? ( sys-libs/libutempter )
	)
	bzip2? ( app-arch/bzip2 )
	fam? ( virtual/fam )
	jpeg2k? ( media-libs/jasper )
	kerberos? ( virtual/krb5 )
	lzma? ( app-arch/xz-utils )
	openexr? (
		media-libs/openexr
		media-libs/ilmbase
	)
	policykit? ( sys-auth/polkit-qt )
	semantic-desktop? (
		>=dev-libs/shared-desktop-ontologies-0.2
		>=dev-libs/soprano-2.3.70[dbus,raptor,redland]
	)
	spell? (
		app-dicts/aspell-en
		app-text/aspell
		app-text/enchant
	)
	ssl? ( dev-libs/openssl )
	zeroconf? (
		|| (
			net-dns/avahi[mdnsresponder-compat]
			!bindist? ( net-misc/mDNSResponder )
		)
	)
"
DEPEND="${COMMONDEPEND}
	doc? ( app-doc/doxygen )
	nls? ( virtual/libintl )
"
RDEPEND="${COMMONDEPEND}
	!dev-libs/conversion
	!dev-libs/kunitconversion
	!x11-libs/qt-phonon
	!<=kde-misc/kdnssd-avahi-0.1.2:0
	>=app-crypt/gnupg-2.0.11
	$(add_kdebase_dep kde-env)
	!aqua? (
		x11-apps/iceauth
		x11-apps/rgb
		>=x11-misc/xdg-utils-1.0.2-r3
	)
"

# Blockers added due to packages from old versions, removed in the meanwhile
# as well as for file collisions
add_blocker libknotificationitem
add_blocker libkworkspace '<4.3.66'
# @since 4.4 - kpilot is gone (blocker added to help upgrades)
add_blocker kpilot
# Block some old versions of KDE-3.5 packages that don't work well with KDE-4
add_blocker kdebase 0 3.5.9-r4:3.5
add_blocker kdebase-startkde 0 3.5.10:3.5
add_blocker kdelibs 0 '<3.5.10:3.5'
# libnepomukquery moved to kdelibs from plasma-workspace between 4.3.74 -> 4.3.75
add_blocker plasma-workspace '<4.3.75'

PATCHES=(
	"${FILESDIR}/dist/01_gentoo_set_xdg_menu_prefix.patch"
	"${FILESDIR}/dist/02_gentoo_append_xdg_config_dirs.patch"
	"${FILESDIR}/dist/23_solid_no_double_build.patch"
	"${FILESDIR}/${PN}-4.3.80-module-suffix.patch"
	"${FILESDIR}/${PN}-4.3.1-macos-unbundle.patch"
	"${FILESDIR}/${PN}-4.3.3-klauncher_kdeinit.patch"
	"${FILESDIR}/${PN}-4.3.3-klauncher_kioslave.patch"
	"${FILESDIR}/${PN}-4.3.3-klauncher_mac.patch"
)

src_prepare() {
	kde4-base_src_prepare

	# Rename applications.menu (needs 01_gentoo_set_xdg_menu_prefix.patch to work)
	local menu_prefix="kde-${SLOT}-"
	sed -e "s|FILES[[:space:]]applications.menu|FILES applications.menu RENAME ${menu_prefix}applications.menu|g" \
		-i kded/CMakeLists.txt || die "Sed on CMakeLists.txt for applications.menu failed."
	sed -e "s|@REPLACE_MENU_PREFIX@|${menu_prefix}|" \
		-i kded/vfolder_menu.cpp || die "Sed on vfolder_menu.cpp failed."

	if use aqua; then
		sed -i -e \
			"s:BUNDLE_INSTALL_DIR \"/Applications:BUNDLE_INSTALL_DIR \"${EPREFIX}/${APP_BUNDLE_DIR}:g" \
			cmake/modules/FindKDE4Internal.cmake || die "failed to sed FindKDE4Internal.cmake"

		#if [[ ${CHOST} == *-darwin8 ]]; then
		sed -i -e \
			"s:set(_add_executable_param MACOSX_BUNDLE):remove(_add_executable_param MACOSX_BUNDLE):g" \
			cmake/modules/KDE4Macros.cmake || die "failed to sed KDE4Macros.cmake"
		#fi

		# solid/solid/backends/iokit doesn't properly link, so disable it.
		sed -e "s|\(APPLE\)|(FALSE)|g" -i solid/solid/CMakeLists.txt \
			|| die "disabling solid/solid/backends/iokit failed"
		sed -e "s|m_backend = .*Backends::IOKit.*;|m_backend = 0;|g" -i solid/solid/managerbase.cpp \
			|| die "disabling solid/solid/backends/iokit failed"

		# There's no fdatasync on OSX and the check fails to detect that.
		sed -e "/HAVE_FDATASYNC/ d" -i config.h.cmake \
			|| die "disabling fdatasync failed"

		# Fix nameser include to nameser8_compat
		sed -e "s|nameser8_compat.h|nameser_compat.h|g" -i kio/misc/kpac/discovery.cpp \
			|| die "fixing nameser include failed"
		append-flags -DHAVE_ARPA_NAMESER8_COMPAT_H=1

		# Try to fix kkeyserver_mac
		epatch "${FILESDIR}"/${PN}-4.3.80-kdeui_util_kkeyserver_mac.patch
	fi

	if [[ ${CHOST} == *-solaris* ]] ; then
		epatch "${FILESDIR}/kdelibs-4.3.2-solaris-ksyscoca.patch"
		# getgrouplist not in solaris libc
		epatch "${FILESDIR}/kdelibs-4.3.2-solaris-getgrouplist.patch"
		# solaris has no d_type element in dir_ent
		epatch "${FILESDIR}/kdelibs-4.3.2-solaris-fileunix.patch"
	fi
}

src_configure() {
	if use zeroconf; then
		if has_version net-dns/avahi; then
			mycmakeargs=(-DWITH_Avahi=ON -DWITH_DNSSD=OFF)
		elif has_version net-misc/mDNSResponder; then
			mycmakeargs=(-DWITH_Avahi=OFF -DWITH_DNSSD=ON)
		else
			die "USE=\"zeroconf\" enabled but neither net-dns/avahi nor net-misc/mDNSResponder were found."
		fi
	else
		mycmakeargs=(-DWITH_Avahi=OFF -DWITH_DNSSD=OFF)
	fi
	if use kdeprefix; then
		HME=".kde${SLOT}"
	else
		HME=".kde4"
	fi
	mycmakeargs+=(
		-DWITH_HSPELL=OFF
		-DKDE_DEFAULT_HOME=${HME}
		-DKAUTH_BACKEND=POLKITQT-1
		$(cmake-utils_use_build handbook doc)
		$(cmake-utils_use_has 3dnow X86_3DNOW)
		$(cmake-utils_use_has altivec PPC_ALTIVEC)
		$(cmake-utils_use_has mmx X86_MMX)
		$(cmake-utils_use_has sse X86_SSE)
		$(cmake-utils_use_has sse2 X86_SSE2)
		$(cmake-utils_use_with acl)
		$(cmake-utils_use_with alsa)
		$(cmake-utils_use_with bzip2 BZip2)
		$(cmake-utils_use_with fam)
		$(cmake-utils_use_with jpeg2k Jasper)
		$(cmake-utils_use_with kerberos GSSAPI)
		$(cmake-utils_use_with lzma LibLZMA)
		$(cmake-utils_use_with nls Libintl)
		$(cmake-utils_use_with openexr OpenEXR)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with policykit PolkitQt-1)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with semantic-desktop SharedDesktopOntologies)
		$(cmake-utils_use_with spell ASPELL)
		$(cmake-utils_use_with spell ENCHANT)
		$(cmake-utils_use_with ssl OpenSSL)
	)
	kde4-base_src_configure
}

src_compile() {
	kde4-base_src_compile

	# The building of apidox is not managed anymore by the build system
	if use doc; then
		einfo "Building API documentation"
		cd "${S}"/doc/api/
		./doxygen.sh "${S}" || die "APIDOX generation failed"
	fi
}

src_install() {
	kde4-base_src_install

	if use doc; then
		einfo "Installing API documentation. This could take a bit of time."
		cd "${S}"/doc/api/
		docinto /HTML/en/kdelibs-apidox
		dohtml -r ${P}-apidocs/* || die "Install phase of KDE4 API Documentation failed"
	fi

	if use aqua; then
		einfo "fixing ${PN} plugins"

		local _PV=${PV:0:3}.0
		local _dir=${EKDEDIR}/$(get_libdir)/kde4/plugins/script

		install_name_tool -id \
			"${_dir}/libkrossqtsplugin.${_PV}.dylib" \
			"${D}/${_dir}/libkrossqtsplugin.${_PV}.dylib" \
			|| die "failed fixing libkrossqtsplugin.${_PV}.dylib"

		einfo "fixing ${PN} cmake detection files"
		#sed -i -e \
		#	"s:if (HAVE_XKB):if (HAVE_XKB AND NOT APPLE):g" \
		echo -e "set(XKB_FOUND FALSE)\nset(HAVE_XKB FALSE)" > \
			"${ED}"/${KDEDIR}/share/apps/cmake/modules/FindXKB.cmake \
			|| die "failed fixing FindXKB.cmake"
	fi
}

pkg_postinst() {
	fdo-mime_mime_database_update

	if use zeroconf; then
		echo
		elog "To make zeroconf support available in KDE make sure that the 'mdnsd' daemon"
		elog "is running."
		echo
		einfo "If you also want to use zeroconf for hostname resolution, emerge sys-auth/nss-mdns"
		einfo "and enable multicast dns lookups by editing the 'hosts:' line in /etc/nsswitch.conf"
		einfo "to include 'mdns', e.g.:"
		einfo "	hosts: files mdns dns"
		echo
	fi

	elog "Your homedir is set to \${HOME}/${HME}"
	echo

	if ! has_version sys-apps/hal; then
		echo
		ewarn "You need sys-apps/hal for new device notifications, power management and any"
		ewarn "other hardware related functionalities to work."
		echo
	fi

	kde4-base_pkg_postinst
}

pkg_prerm() {
	# Remove ksycoca4 global database
	rm -f "${EROOT}${PREFIX}"/share/kde4/services/ksycoca4
}

pkg_postrm() {
	fdo-mime_mime_database_update

	kde4-base_pkg_postrm
}
