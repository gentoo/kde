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

src_install() {
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
XDG_DATA_DIRS="${PREFIX}/share"
KDEDIRS="/usr"
EOF
		doenvd "${T}"/43kdepaths-${SLOT}
		cat <<-EOF > "${D}/etc/revdep-rebuild/50-kde-${SLOT}"
SEARCH_DIRS="${PREFIX}/bin ${PREFIX}/lib*"
EOF
	else # Much simpler for the FHS compliant -kdeprefix install
		cat <<-EOF > "${T}"/43kdepaths # number goes down with version
CONFIG_PROTECT="/usr/share/config"
#KDE_IS_PRELINKED=1
		EOF
		doenvd "${T}"/43kdepaths
	fi
}

pkg_preinst() {
	:
}
