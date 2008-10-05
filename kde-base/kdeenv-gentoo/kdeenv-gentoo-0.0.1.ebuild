# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit multilib

DESCRIPTION="Gentoo KDE env files."
HOMEPAGE="http://kde.gentoo.org/"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="LGPL-2.1"

PDEPEND="kde-base/kdebase-startkde"

src_install() {

	dodir /etc/env.d
	dodir /etc/revdep-rebuild

	# List all the multilib libdirs
	local _libdir _libdirs
	for _libdir in $(get_all_libdirs); do
		_libdirs="${_libdirs}:\${KDEDIR}/${_libdir}"
	done
	_libdirs=${_libdirs#:}

	cat <<-EOF > "${T}"/42kdepaths
	PATH="\${KDEDIR}/bin"
	ROOTPATH="\${KDEDIR}/sbin:\${KDEDIR}/bin"
	LDPATH="${_libdirs}"
	MANPATH="\${KDEDIR}/share/man"
	CONFIG_PROTECT="\${KDEDIR}/share/config \${KDEDIR}/env \${KDEDIR}/shutdown /usr/share/config"
	XDG_DATA_DIRS="/usr/share:\${KDEDIR}/share:/usr/local/share"
	COLON_SEPARATED="XDG_DATA_DIRS"
	EOF
	doenvd "${T}"/42kdepaths

	# make sure 'source /etc/profile' doesn't hose the PATH
	dodir /etc/profile.d
	cat <<-'EOF' > "${D}"/etc/profile.d/42kdereorderpaths.sh
	if [ -n "${KDEDIR}" ]; then
		export PATH=${KDEDIR}/bin:$(echo ${PATH} | sed "s#${KDEDIR}/s\?bin:##g")
		export ROOTPATH=${KDEDIR}/sbin:${KDEDIR}/bin:$(echo ${PATH} | sed "s#${KDEDIR}/s\?bin:##g")
	fi
	EOF

	cat <<-EOF > "${D}/etc/revdep-rebuild/50-kde-${SLOT}"
	SEARCH_DIRS="\${KDEDIR}/bin \${KDEDIR}/lib*"
	EOF
}
