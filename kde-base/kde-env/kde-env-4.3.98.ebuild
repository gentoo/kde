# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

CMAKE_REQUIRED="never"
KDE_REQUIRED="never"
inherit kde4-base

DESCRIPTION="Environment setting required for all KDE4 apps to run."
HOMEPAGE="http://kde.org"
[[ ${PV} = *9999* ]] && ESVN_REPO_URI="" || SRC_URI=""

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
LICENSE="as-is"
IUSE="aqua"

add_blocker kdelibs 4.2.2-r1 '<3.5.10-r3:3.5' 4.2.70:4.3

S=${WORKDIR}

src_unpack() { :; }
src_prepare() { :; }

src_install() {
	if use kdeprefix; then
		# List all the multilib libdirs
		local _libdir _libdirs
		for _libdir in $(get_all_libdirs); do
			_libdirs+=":${EKDEDIR}/${_libdir}"
		done
		_libdirs=${_libdirs#:}

		# number goes down with version
		cat <<-EOF > 43kdepaths-${SLOT}
PATH="${EKDEDIR}/bin"
ROOTPATH="${EKDEDIR}/sbin:${EKDEDIR}/bin"
LDPATH="${_libdirs}"
MANPATH="${EKDEDIR}/share/man"
CONFIG_PROTECT="${KDEDIR}/share/config ${KDEDIR}/env ${KDEDIR}/shutdown /usr/share/config"
#KDE_IS_PRELINKED=1
PKG_CONFIG_PATH="${EKDEDIR}/$(get_libdir)/pkgconfig"
XDG_DATA_DIRS="${EKDEDIR}/share"
EOF
		doenvd 43kdepaths-${SLOT}
		cat <<-EOF > 50-kde-${SLOT}
SEARCH_DIRS="${EKDEDIR}/bin ${EKDEDIR}/lib*"
EOF
		insinto /etc/revdep-rebuild
		doins 50-kde-${SLOT}

		# kdeglobals needed to make third party apps installed in /usr work
		cat <<-EOF > kdeglobals
[Directories][\$i]
prefixes=${EPREFIX}/usr
EOF
		insinto ${KDEDIR}/share/config
		doins kdeglobals
	else
		# Much simpler for the FHS compliant -kdeprefix install
		# number goes down with version
		cat <<-EOF > 43kdepaths
CONFIG_PROTECT="/usr/share/config"
#KDE_IS_PRELINKED=1
EOF
		doenvd 43kdepaths
	fi
}
