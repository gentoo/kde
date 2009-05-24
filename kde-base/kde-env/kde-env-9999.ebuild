# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="Environment setting required for all KDE4 apps to run."
HOMEPAGE="http://kde.org"
ESVN_REPO_URI=""

KEYWORDS=""
LICENSE="as-is"
IUSE=""

RDEPEND="
	!<kde-base/kdelibs-3.5.10-r3
	!kdeprefix? (
		!kde-base/kdelibs:4.1
		!<=kde-base/kdelibs-4.2.2-r1:4.2
		!<=kde-base/kdelibs-4.2.70:4.3
	)
	kdeprefix? ( !<kde-base/kdelibs-${PV}:${SLOT} )
"

src_unpack() {
	:
}

src_prepare() {
	:
}

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	dodir /etc/env.d
	dodir /etc/revdep-rebuild
	dodir "${PREFIX}/share/config"

	# List all the multilib libdirs
	local _libdir _libdirs
	for _libdir in $(get_all_libdirs); do
		_libdirs="${_libdirs}:${PREFIX}/${_libdir}"
	done
	_libdirs=${_libdirs#:}

	if use kdeprefix; then

		# number goes down with version
		cat <<-EOF > "${T}/43kdepaths-${SLOT}"
PATH="${PREFIX}/bin"
ROOTPATH="${PREFIX}/sbin:${PREFIX}/bin"
LDPATH="${_libdirs}"
MANPATH="${PREFIX}/share/man"
CONFIG_PROTECT="${PREFIX}/share/config ${PREFIX}/env ${PREFIX}/shutdown /usr/share/config"
#KDE_IS_PRELINKED=1
PKG_CONFIG_PATH="${PREFIX}/$(get_libdir)/pkgconfig"
XDG_DATA_DIRS="${PREFIX}/share"
KDEDIRS="/usr"
EOF
		doenvd "${T}/43kdepaths-${SLOT}"
		cat <<-EOF > "${D}/etc/revdep-rebuild/50-kde-${SLOT}"
SEARCH_DIRS="${PREFIX}/bin ${PREFIX}/lib*"
EOF

		# kdeglobals needed to make third party apps installed in /usr work
		cat <<-EOF > "${D}/${PREFIX}/share/config/kdeglobals"
[Directories][\$i]
dir_data=${PREFIX}/share/apps:/usr/share/apps
dir_html=${PREFIX}/share/doc/HTML:/usr/share/doc/HTML
dir_icon=${PREFIX}/share/icons:/usr/share/icons
dir_config=${PREFIX}/share/config:/usr/share/config
dir_pixmap=${PREFIX}/share/pixmaps:/usr/share/pixmaps
dir_apps=${PREFIX}/share/applnk:/usr/share/applnk
dir_sound=${PREFIX}/share/sounds:/usr/share/sounds
dir_locale=${PREFIX}/share/locale:/usr/share/locale
dir_services=${PREFIX}/share/kde4/services:/usr/share/kde4/services
dir_servicetypes=${PREFIX}/share/kde4/servicetypes:/usr/share/kde4/servicetypes
dir_mime=${PREFIX}/share/mimelnk:/usr/share/mimelnk
dir_wallpapers=${PREFIX}/share/wallpapers:/usr/share/wallpapers
dir_templates=${PREFIX}/share/templates:/usr/share/templates
dir_exe=${PREFIX}/$(get_libdir)/kde4/libexec:${PREFIX}/bin:/usr/$(get_libdir)/kde4/libexec:/usr/bin
dir_module=${PREFIX}/$(get_libdir)/kde4:/usr/$(get_libdir)/kde4
dir_qtplugins=${PREFIX}/$(get_libdir)/kde4/plugins:/usr/$(get_libdir)/kde4/plugins
dir_kcfg=${PREFIX}/share/config.kcfg:/usr/share/config.kcfg
dir_lib=${PREFIX}/$(get_libdir):/usr/$(get_libdir)
dir_emoticons=${PREFIX}/share/emoticons:/usr/share/emoticons
dir_xdgdata-apps=${PREFIX}/share/applications:/usr/share/applications
dir_xdgdata-icons=${PREFIX}/share/icons:/usr/share/icons
dir_xdgdata-pixmaps=${PREFIX}/share/pixmaps:/usr/share/pixmaps
EOF

	else

		# Much simpler for the FHS compliant -kdeprefix install
		# number goes down with version
		cat <<-EOF > "${T}/43kdepaths"
CONFIG_PROTECT="/usr/share/config"
#KDE_IS_PRELINKED=1
EOF
		doenvd "${T}/43kdepaths"

	fi
}

pkg_preinst() {
	:
}

src_test() {
	:
}
