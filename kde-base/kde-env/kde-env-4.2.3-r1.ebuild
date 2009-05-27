# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-env/kde-env-4.2.3.ebuild,v 1.4 2009/05/09 13:41:20 scarabeus Exp $

EAPI="2"

inherit kde4-base

DESCRIPTION="Environment setting required for all KDE4 apps to run."
HOMEPAGE="http://kde.org"
SRC_URI=""

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
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
EOF
		doenvd "${T}/43kdepaths-${SLOT}"
		cat <<-EOF > "${D}/etc/revdep-rebuild/50-kde-${SLOT}"
SEARCH_DIRS="${PREFIX}/bin ${PREFIX}/lib*"
EOF

		# kdeglobals needed to make third party apps installed in /usr work
		cat <<-EOF > "${D}/${PREFIX}/share/config/kdeglobals"
[Directories][\$i]
prefixes=/usr
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
