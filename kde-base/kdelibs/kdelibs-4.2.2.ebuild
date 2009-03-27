# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-4.2.1-r3.ebuild,v 1.1 2009/03/23 04:37:11 jmbsvicetto Exp $

EAPI="2"

CPPUNIT_REQUIRED="optional"
OPENGL_REQUIRED="optional"
WEBKIT_REQUIRED="optional"
inherit kde4-base fdo-mime

DESCRIPTION="KDE libraries needed by all KDE programs."
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="3dnow acl alsa altivec bindist +bzip2 debug doc fam jpeg2k kerberos
mmx nls openexr plasma +semantic-desktop spell sse sse2 ssl zeroconf"
LICENSE="LGPL-2.1"
RESTRICT="test"

COMMONDEPEND="
	>=app-misc/strigi-0.6.3[qt4,dbus]
	dev-libs/libpcre
	dev-libs/libxml2
	dev-libs/libxslt
	>=kde-base/automoc-0.9.87
	media-fonts/dejavu
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/giflib
	media-libs/jpeg
	media-libs/libpng
	>=media-sound/phonon-4.3.1[xcb]
	sys-apps/dbus[X]
	sys-libs/zlib
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
	x11-misc/shared-mime-info
	acl? (
		kernel_linux? ( sys-apps/acl )
	)
	alsa? ( media-libs/alsa-lib[midi] )
	bzip2? ( app-arch/bzip2 )
	fam? ( virtual/fam )
	jpeg2k? ( media-libs/jasper )
	kerberos? ( virtual/krb5 )
	openexr? (
		media-libs/openexr
		media-libs/ilmbase
	)
	opengl? ( virtual/opengl )
	plasma? ( >=x11-base/xorg-server-1.5.2 )
	semantic-desktop? ( >=dev-libs/soprano-2.2.2[dbus] )
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
# Blockers added for !kdeprefix? due to packages from old versions,
# removed in the meanwhile
# kde-base/libplasma
# kde-base/knewsticker
# kde-base/kpercentage
# kde-base/ktnef
RDEPEND="${COMMONDEPEND}
	!<=kde-base/kdebase-3.5.9-r4
	!<=kde-base/kdebase-startkde-3.5.10
	!<kde-base/kdelibs-3.5.10
	!x11-libs/qt-phonon
	!kdeprefix? (
		!kde-base/kitchensync:4.1
		!kde-base/knewsticker:4.1
		!kde-base/kpercentage:4.1
		!kde-base/ktnef:4.1
		!<kde-base/libkworkspace-${PV}[-kdeprefix]
		!kde-base/libplasma
		!<=kde-misc/kdnssd-avahi-0.1.2:0
	)
	kdeprefix? (
		!<kde-base/libkworkspace-${PV}:${SLOT}
		!<=kde-misc/kdnssd-avahi-0.1.2:0
	)
	x11-apps/iceauth
	x11-apps/rgb
"

# upstream patches / dist patches
# {FILESDIR}/${P}-qt4.5.patch is upstream revision 934640
# and fixes upstream bug 186038 and Gentoo bug 261367
# ${FILESDIR}/${P}-kcatalog.patch fixes gwenview and other issues on both bugs
# ${FILESDIR}/${P}-kdialog.patch is upstream revision 938657 and fixes the
# systemsettings title issue
PATCHES=(
	"${FILESDIR}/dist/09_disable_debug_messages_if_not_explicitly_enabled.patch"
	"${FILESDIR}/dist/20_use_dejavu_as_default_font.patch"
	"${FILESDIR}/dist/23_solid_no_double_build.patch"
	"${FILESDIR}/${P}-qt4.5.patch"
	"${FILESDIR}/${P}-kcatalog.patch"
	"${FILESDIR}/${P}-kdialog.patch"
)

src_prepare() {
	sed -i -e 's/find_package(ACL)/macro_optional_find_package(ACL)/' \
		CMakeLists.txt \
		|| die "Failed to make ACL disabled even when present in system."

	kde4-base_src_prepare
}

src_configure() {
	if use zeroconf; then
		if has_version net-dns/avahi; then
			mycmakeargs="${mycmakeargs} -DWITH_Avahi=ON -DWITH_DNSSD=OFF"
		elif has_version net-misc/mDNSResponder; then
			mycmakeargs="${mycmakeargs} -DWITH_Avahi=OFF -DWITH_DNSSD=ON"
		else
			die "USE=\"zeroconf\" enabled but neither net-dns/avahi nor net-misc/mDNSResponder were found."
		fi
	fi
	if use kdeprefix; then
		HME=".kde${SLOT}"
	else
		HME=".kde4"
	fi
	mycmakeargs="${mycmakeargs}
		-DWITH_HSPELL=OFF
		-DKDE_DEFAULT_HOME=${HME}
		$(cmake-utils_use_has 3dnow X86_3DNOW)
		$(cmake-utils_use_has altivec PPC_ALTIVEC)
		$(cmake-utils_use_has mmx X86_MMX)
		$(cmake-utils_use_has sse X86_SSE)
		$(cmake-utils_use_has sse2 X86_SSE2)
		$(cmake-utils_use_with acl ACL)
		$(cmake-utils_use_with alsa Alsa)
		$(cmake-utils_use_with bzip2 BZip2)
		$(cmake-utils_use_with fam FAM)
		$(cmake-utils_use_with jpeg2k Jasper)
		$(cmake-utils_use_with kerberos GSSAPI)
		$(cmake-utils_use_with nls Libintl)
		$(cmake-utils_use_with openexr OpenEXR)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with spell ASPELL)
		$(cmake-utils_use_with spell ENCHANT)
		$(cmake-utils_use_with ssl OpenSSL)
	"
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

	dodir /etc/env.d
	dodir /etc/revdep-rebuild

	# List all the multilib libdirs
	local _libdir _libdirs
	for _libdir in $(get_all_libdirs); do
		_libdirs="${_libdirs}:${PREFIX}/${_libdir}"
	done
	_libdirs=${_libdirs#:}

	if use kdeprefix; then
		cat <<-EOF > "${T}"/43kdepaths-${SLOT} # number goes down with version
PATH="${PREFIX}/bin"
ROOTPATH="${PREFIX}/sbin:${PREFIX}/bin"
LDPATH="${_libdirs}"
MANPATH="${PREFIX}/share/man"
CONFIG_PROTECT="${PREFIX}/share/config ${PREFIX}/env ${PREFIX}/shutdown /usr/share/config"
#KDE_IS_PRELINKED=1
XDG_DATA_DIRS="/usr/share:${PREFIX}/share:/usr/local/share"
COLON_SEPARATED="XDG_DATA_DIRS"
EOF
		doenvd "${T}"/43kdepaths-${SLOT}

		# make sure 'source /etc/profile' doesn't hose the PATH
		dodir /etc/profile.d
		cat <<-'EOF' > "${D}"/etc/profile.d/44kdereorderpaths-${SLOT}.sh
if [ -n "${KDEDIR}" ]; then
	export PATH=${KDEDIR}/bin:$(echo ${PATH} | sed "s#${KDEDIR}/s\?bin:##g")
	export ROOTPATH=${KDEDIR}/sbin:${KDEDIR}/bin:$(echo ${PATH} | sed "s#${KDEDIR}/s\?bin:##g")
fi
EOF

		cat <<-EOF > "${D}/etc/revdep-rebuild/50-kde-${SLOT}"
SEARCH_DIRS="${PREFIX}/bin ${PREFIX}/lib*"
EOF
	else # Much simpler for the FHS compliant -kdeprefix install
		cat <<-EOF > "${T}"/43kdepaths # number goes down with version
CONFIG_PROTECT="/usr/share/config"
#KDE_IS_PRELINKED=1
XDG_DATA_DIRS="/usr/share:/usr/local/share"
COLON_SEPARATED="XDG_DATA_DIRS"
		EOF
		doenvd "${T}"/43kdepaths
	fi
	# Ensure that the correct permissions are set on ${PREFIX}/share/config
	fperms 755 "${PREFIX}"/share/config
}

pkg_postinst() {
	fdo-mime_mime_database_update
	if use zeroconf; then
		echo
		elog "To make zeroconf support available in KDE make sure that the 'mdnsd' daemon"
		elog "is running. Make sure also that multicast dns lookups are enabled by editing"
		elog "the 'hosts:' line in /etc/nsswitch.conf to include 'mdns', e.g.:"
		elog "	hosts: files mdns dns"
		echo
	fi
	elog "Your homedir is set to "'${HOME}'"/${HME}"
	elog
	elog "If you experience weird application behavior (missing texts, etc.) run as root:"
	elog "# chmod 755 -R /usr/share/config $PREFIX/share/config"

	kde4-base_pkg_postinst
}

pkg_postrm() {
	fdo-mime_mime_database_update

	kde4-base_pkg_postrm
}
