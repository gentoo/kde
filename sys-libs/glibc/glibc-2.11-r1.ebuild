# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/glibc/glibc-2.11.ebuild,v 1.7 2009/11/10 02:04:41 vapier Exp $

inherit eutils versionator libtool toolchain-funcs flag-o-matic gnuconfig multilib

DESCRIPTION="GNU libc6 (also called glibc2) C library"
HOMEPAGE="http://www.gnu.org/software/libc/libc.html"

LICENSE="LGPL-2"
KEYWORDS="~amd64 ~ia64 ~s390 ~sparc ~x86"
RESTRICT="strip" # strip ourself #46186
EMULTILIB_PKG="true"

# Configuration variables
if [[ ${PV} == *_p* ]] ; then
RELEASE_VER=${PV%_p*}
BRANCH_UPDATE=""
SNAP_VER=${PV#*_p}
else
RELEASE_VER=${PV}
BRANCH_UPDATE=""
SNAP_VER=""
fi
MANPAGE_VER=""                                 # pregenerated manpages
INFOPAGE_VER=""                                # pregenerated infopages
LIBIDN_VER=""                                  # it's integrated into the main tarball now
PATCH_VER="3"                                  # Gentoo patchset
PORTS_VER= #${RELEASE_VER}                     # version of glibc ports addon
LT_VER=""                                      # version of linuxthreads addon
NPTL_KERN_VER=${NPTL_KERN_VER:-"2.6.9"}        # min kernel version nptl requires
#LT_KERN_VER=${LT_KERN_VER:-"2.4.1"}           # min kernel version linuxthreads requires

IUSE="debug gd glibc-omitfp hardened multilib nls selinux profile vanilla crosscompile_opts_headers-only ${LT_VER:+glibc-compat20 nptl nptlonly}"
S=${WORKDIR}/glibc-${RELEASE_VER}${SNAP_VER:+-${SNAP_VER}}

# Here's how the cross-compile logic breaks down ...
#  CTARGET - machine that will target the binaries
#  CHOST   - machine that will host the binaries
#  CBUILD  - machine that will build the binaries
# If CTARGET != CHOST, it means you want a libc for cross-compiling.
# If CHOST != CBUILD, it means you want to cross-compile the libc.
#  CBUILD = CHOST = CTARGET    - native build/install
#  CBUILD != (CHOST = CTARGET) - cross-compile a native build
#  (CBUILD = CHOST) != CTARGET - libc for cross-compiler
#  CBUILD != CHOST != CTARGET  - cross-compile a libc for a cross-compiler
# For install paths:
#  CHOST = CTARGET  - install into /
#  CHOST != CTARGET - install into /usr/CTARGET/

export CBUILD=${CBUILD:-${CHOST}}
export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi

[[ ${CTARGET} == hppa* ]] && NPTL_KERN_VER=${NPTL_KERN_VER/2.6.9/2.6.20}

is_crosscompile() {
	[[ ${CHOST} != ${CTARGET} ]]
}
alt_libdir() {
	if is_crosscompile ; then
		echo /usr/${CTARGET}/$(get_libdir)
	else
		echo /$(get_libdir)
	fi
}

if is_crosscompile ; then
	SLOT="${CTARGET}-2.2"
else
	# Why SLOT 2.2 you ask yourself while sippin your tea ?
	# Everyone knows 2.2 > 0, duh.
	SLOT="2.2"
	PROVIDE="virtual/libc"
fi

# General: We need a new-enough binutils for as-needed
# arch: we need to make sure our binutils/gcc supports TLS
DEPEND=">=sys-devel/gcc-3.4.4
	arm? ( >=sys-devel/binutils-2.16.90 >=sys-devel/gcc-4.1.0 )
	x86? ( >=sys-devel/gcc-4.3 )
	amd64? ( >=sys-devel/binutils-2.19 multilib? ( >=sys-devel/gcc-4.3 ) )
	ppc? ( >=sys-devel/gcc-4.1.0 )
	ppc64? ( >=sys-devel/gcc-4.1.0 )
	>=sys-devel/binutils-2.15.94
	${LT_VER:+nptl? (} >=sys-kernel/linux-headers-${NPTL_KERN_VER} ${LT_VER:+)}
	>=sys-devel/gcc-config-1.3.12
	>=app-misc/pax-utils-0.1.10
	virtual/os-headers
	nls? ( sys-devel/gettext )
	>=sys-apps/sandbox-1.2.18.1-r2
	>=sys-apps/portage-2.1.2
	selinux? ( sys-libs/libselinux )"
RDEPEND="!sys-kernel/ps3-sources
	nls? ( sys-devel/gettext )
	selinux? ( sys-libs/libselinux )"

if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
	DEPEND="${DEPEND} ${CATEGORY}/gcc"
	[[ ${CATEGORY} == *-linux* ]] && DEPEND="${DEPEND} ${CATEGORY}/linux-headers"
else
	DEPEND="${DEPEND} >=sys-libs/timezone-data-2007c"
	RDEPEND="${RDEPEND} sys-libs/timezone-data"
fi

SRC_URI=$(
	upstream_uris() {
		echo mirror://gnu/glibc/$1 ftp://sources.redhat.com/pub/glibc/{releases,snapshots}/$1 mirror://gentoo/$1
	}
	gentoo_uris() {
		local devspace="HTTP~vapier/dist/URI HTTP~azarah/glibc/URI"
		devspace=${devspace//HTTP/http://dev.gentoo.org/}
		echo mirror://gentoo/$1 ${devspace//URI/$1}
	}

	TARNAME=${PN}
	if [[ -n ${SNAP_VER} ]] ; then
		TARNAME="${PN}-${RELEASE_VER}"
		[[ -n ${PORTS_VER} ]] && PORTS_VER=${SNAP_VER}
		upstream_uris ${TARNAME}-${SNAP_VER}.tar.bz2
	else
		upstream_uris ${TARNAME}-${RELEASE_VER}.tar.bz2
	fi
	[[ -n ${LIBIDN_VER}    ]] && upstream_uris glibc-libidn-${LIBIDN_VER}.tar.bz2
	[[ -n ${PORTS_VER}     ]] && upstream_uris ${TARNAME}-ports-${PORTS_VER}.tar.bz2
	[[ -n ${LT_VER}        ]] && upstream_uris ${TARNAME}-linuxthreads-${LT_VER}.tar.bz2
	[[ -n ${BRANCH_UPDATE} ]] && gentoo_uris glibc-${RELEASE_VER}-branch-update-${BRANCH_UPDATE}.patch.bz2
	[[ -n ${PATCH_VER}     ]] && gentoo_uris glibc-${RELEASE_VER}-patches-${PATCH_VER}.tar.bz2
	[[ -n ${MANPAGE_VER}   ]] && gentoo_uris glibc-manpages-${MANPAGE_VER}.tar.bz2
	[[ -n ${INFOPAGE_VER}  ]] && gentoo_uris glibc-infopages-${INFOPAGE_VER}.tar.bz2
)

# eblit-include [--skip] <function> [version]
eblit-include() {
	local skipable=false
	[[ $1 == "--skip" ]] && skipable=true && shift
	[[ $1 == pkg_* ]] && skipable=true

	local e v func=$1 ver=$2
	[[ -z ${func} ]] && die "Usage: eblit-include <function> [version]"
	for v in ${ver:+-}${ver} -${PVR} -${PV} "" ; do
		e="${FILESDIR}/eblits/${func}${v}.eblit"
		if [[ -e ${e} ]] ; then
			source "${e}"
			return 0
		fi
	done
	${skipable} && return 0
	die "Could not locate requested eblit '${func}' in ${FILESDIR}/eblits/"
}

# eblit-run-maybe <function>
# run the specified function if it is defined
eblit-run-maybe() {
	[[ $(type -t "$@") == "function" ]] && "$@"
}

# eblit-run <function> [version]
# aka: src_unpack() { eblit-run src_unpack ; }
eblit-run() {
	eblit-include --skip common "${*:2}"
	eblit-include "$@"
	eblit-run-maybe eblit-$1-pre
	eblit-${PN}-$1
	eblit-run-maybe eblit-$1-post
}

src_unpack()  { eblit-run src_unpack  ; }
src_compile() { eblit-run src_compile ; }
src_test()    { eblit-run src_test    ; }
src_install() { eblit-run src_install ; }

# FILESDIR might not be available during binpkg install
for x in setup {pre,post}inst ; do
	e="${FILESDIR}/eblits/pkg_${x}.eblit"
	if [[ -e ${e} ]] ; then
		. "${e}"
		eval "pkg_${x}() { eblit-run pkg_${x} ; }"
	fi
done

eblit-src_unpack-post() {
	cd "${S}"
	if use hardened ; then
		einfo "Patching to get working PIE binaries on PIE (hardened) platforms"
		gcc-specs-pie && epatch "${FILESDIR}"/2.11/glibc-2.11-hardened-pie.patch
		epatch "${FILESDIR}"/2.10/glibc-2.10-hardened-configure-picdefault.patch
		epatch "${FILESDIR}"/2.10/glibc-2.10-hardened-inittls-nosysenter.patch

		einfo "Patching Glibc to support older SSP __guard"
		epatch "${FILESDIR}"/2.10/glibc-2.10-hardened-ssp-compat.patch

		einfo "Installing Hardened Gentoo SSP and FORTIFY_SOURCE handler"
		cp -f "${FILESDIR}"/2.6/glibc-2.6-gentoo-stack_chk_fail.c \
			debug/stack_chk_fail.c || die
		cp -f "${FILESDIR}"/2.10/glibc-2.10-gentoo-chk_fail.c \
			debug/chk_fail.c || die

		if use debug ; then
			# When using Hardened Gentoo stack handler, have smashes dump core for
			# analysis - debug only, as core could be an information leak
			# (paranoia).
			sed -i \
				-e '/^CFLAGS-backtrace.c/ iCFLAGS-stack_chk_fail.c = -DSSP_SMASH_DUMPS_CORE' \
				debug/Makefile \
				|| die "Failed to modify debug/Makefile for debug stack handler"
			sed -i \
				-e '/^CFLAGS-backtrace.c/ iCFLAGS-chk_fail.c = -DSSP_SMASH_DUMPS_CORE' \
				debug/Makefile \
				|| die "Failed to modify debug/Makefile for debug fortify handler"
		fi

		# Build nscd with ssp-all
		sed -i \
			-e 's:-fstack-protector$:-fstack-protector-all:' \
			nscd/Makefile \
			|| die "Failed to ensure nscd builds with ssp-all"
	fi

	epatch "${FILESDIR}/${PV}/${P}-deadlock-free.patch"
}

maint_pkg_create() {
	local base="/usr/local/src/gnu/glibc/glibc-${PV:0:1}_${PV:2:1}"
	cd ${base}
	local stamp=$(date +%Y%m%d)
	local d
	for d in libc ports ; do
		#(cd ${d} && cvs up)
		case ${d} in
			libc)  tarball="${P}";;
			ports) tarball="${PN}-ports-${PV}";;
		esac
		rm -f ${tarball}*
		ln -sf ${d} ${tarball}
		tar hcf - ${tarball} --exclude-vcs | lzma > "${T}"/${tarball}.tar.lzma
		du -b "${T}"/${tarball}.tar.lzma
	done
}
