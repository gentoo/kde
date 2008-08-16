# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

CPPUNIT_REQUIRED="optional"
OPENGL_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="KDE libraries needed by all KDE programs."
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~x86"
IUSE="3dnow acl alsa altivec bindist +bzip2 debug doc fam htmlhandbook jpeg2k
kerberos mmx nls openexr +semantic-desktop spell sse sse2 ssl zeroconf"
LICENSE="LGPL-2.1"
RESTRICT="test"

COMMONDEPEND="
	!<kde-base/kdebase-3.5.7-r6
	!<kde-base/kdebase-startkde-3.5.7-r1
	!=kde-base/kdebase-3.5.8
	!=kde-base/kdebase-3.5.8-r1
	!=kde-base/kdebase-3.5.8-r2
	!=kde-base/kdebase-startkde-3.5.8
	>=app-misc/strigi-0.5.9
	>=dev-libs/libxml2-2.6.6
	>=dev-libs/libxslt-1.1.17
	media-libs/fontconfig
	>=media-libs/freetype-2
	media-libs/giflib
	media-libs/jpeg
	media-libs/libpng
	media-sound/phonon
	>=sys-apps/dbus-0.91
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
	>=x11-misc/shared-mime-info-0.20
	acl? ( kernel_linux? ( sys-apps/acl ) )
	alsa? ( >=media-libs/alsa-lib-1.0.14a )
	fam? ( virtual/fam )
	jpeg2k? ( media-libs/jasper )
	kerberos? ( virtual/krb5 )
	nls? ( virtual/libintl )
	openexr? ( >=media-libs/openexr-1.2.2-r2 media-libs/ilmbase )
	opengl? ( virtual/opengl )
	>=dev-libs/libpcre-4.5
	semantic-desktop? ( >=dev-libs/soprano-2.0.0 )
	spell? ( app-text/aspell app-dicts/aspell-en app-text/enchant )
	ssl? ( >=dev-libs/openssl-0.9.7d )
	zeroconf? ( || ( net-dns/avahi
		!bindist? ( net-misc/mDNSResponder ) ) )
"

DEPEND="${COMMONDEPEND}
	doc? ( app-doc/doxygen )
	sys-devel/gettext
"

RDEPEND="${COMMONDEPEND}
	x11-apps/rgb
	x11-apps/iceauth
"

pkg_setup() {
	KDE4_BUILT_WITH_USE_CHECK=("--missing true sys-apps/dbus X")
	if use alsa; then
		KDE4_BUILT_WITH_USE_CHECK+=("--missing true media-libs/alsa-lib midi")
	fi
	if use zeroconf && has_version net-dns/avahi; then
		KDE4_BUILT_WITH_USE_CHECK+=("net-dns/avahi mdnsresponder-compat")
	fi

	kde4-base_pkg_setup
}

src_compile() {
	if use zeroconf; then
		if has_version net-dns/avahi; then
			mycmakeargs="${mycmakeargs} -DWITH_Avahi=ON -DWITH_DNSSD=OFF"
		elif has_version net-misc/mDNSResponder; then
			mycmakeargs="${mycmakeargs} -DWITH_Avahi=OFF -DWITH_DNSSD=ON"
		else
			die "USE=\"zeroconf\" enabled but neither net-dns/avahi nor net-misc/mDNSResponder were found."
		fi
	fi

	mycmakeargs="${mycmakeargs}
		-DWITH_HSPELL=OFF
		$(cmake-utils_has 3dnow X86_3DNOW)
		$(cmake-utils_has altivec PPC_ALTIVEC)
		$(cmake-utils_has mmx X86_MMX)
		$(cmake-utils_has sse X86_SSE)
		$(cmake-utils_has sse2 X86_SSE2)
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

	cat <<-EOF > "${T}"/43kdepaths-${SLOT} # number goes down with version bump
	PATH="${PREFIX}/bin"
	ROOTPATH="${PREFIX}/sbin:${PREFIX}/bin"
	LDPATH="${_libdirs}"
	MANPATH="${PREFIX}/share/man"
	CONFIG_PROTECT="${PREFIX}/share/config ${PREFIX}/env ${PREFIX}/shutdown /usr/share/config"
	KDEDIRS="/usr:/usr/local:${PREFIX}"
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
}

pkg_postinst() {
	if use zeroconf; then
		echo
		elog "To make zeroconf support available in KDE make sure that the 'mdnsd' daemon"
		elog "is running. Make sure also that multicast dns lookups are enabled by editing"
		elog "the 'hosts:' line in /etc/nsswitch.conf to include 'mdns', e.g.:"
		elog "	hosts: files mdns dns"
		echo
	fi

	kde4-base_pkg_postinst
}
