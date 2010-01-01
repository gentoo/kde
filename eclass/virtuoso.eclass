# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: virtuoso.eclass
# @MAINTAINER:
# Maciej Mrozowski <reavertm@poczta.fm>
#
# @BLURB: Provides splitting functionality for Virtuoso
# @DESCRIPTION:
# This eclass provides common code for splitting Virtuoso OpenSource database

case ${EAPI:-0} in
	2|3) : ;;
	*) DEPEND="EAPI-TOO-OLD" ;;
esac

inherit base autotools flag-o-matic multilib

MY_P="virtuoso-opensource-${PV}"

case ${PV} in
	*9999*)
		ECVS_SERVER="virtuoso.cvs.sourceforge.net:/cvsroot/virtuoso"
		SRC_URI=""
		inherit cvs
		;;
	*)
		# Use this variable to determine distribution method (live or tarball)
		TARBALL="${MY_P}.tar.gz"
		SRC_URI="mirror://sourceforge/virtuoso/${TARBALL}"
		;;
esac

EXPORT_FUNCTIONS src_prepare src_configure src_compile src_install

# Set some defaults
HOMEPAGE="http://virtuoso.openlinksw.com/wiki/main/Main/"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=sys-devel/libtool-2.2.6a"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

# @FUNCTION: virtuoso_src_prepare
# @DESCRIPTION:
# 1. Applies common release patches (from ${FILESDIR}/${PV}/ dir)
# 2. Applies package-specific patches (from ${FILESDIR}/, PATCHES can be used)
# 3. Modifies makefiles for split build. Uses VOS_EXTRACT
# 4. eautoreconf
virtuoso_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	for file in "${FILESDIR}/${PV}"/*; do
		epatch "${file}"
	done

	base_src_prepare

	# @ECLASS-VARIABLE: VOS_EXTRACT
	# @DESCRIPTION:
	# Lists any subdirectories that are required to be extracted
	# and enabled in Makefile.am's for current package.
	if [[ -n ${VOS_EXTRACT} ]]; then
		# Comment out everything
		find . -name Makefile.am -exec \
			sed -e '/SUBDIRS\s*=/s/^/# DISABLED /g' -i {} + \
				|| die "failed to disable subdirs"

		# Uncomment specified
		local path
		for path in ${VOS_EXTRACT}; do
			if [[ -d "${path}" ]]; then
				# Uncomment leaf
				if [[ -f "${path}"/Makefile.am ]]; then
					sed -e '/^# DISABLED \s*SUBDIRS\s*=/s/# DISABLED //g' \
						-i "${path}"/Makefile.am || die "failed to uncomment leaf in ${path}/Makefile.am"
				fi
				# Process remaining path elements
				while true; do
					local subdir=`basename "${path}"`
					path=`dirname "${path}"`
					if [[ -f "${path}"/Makefile.am ]]; then
						# Uncomment if necessary
						sed -e '/^# DISABLED \s*SUBDIRS\s*=/s/.*/SUBDIRS =/g' \
							-i "${path}"/Makefile.am
						# Append subdirs if not there already
						if [[ -z `grep --color=never -P "SUBDIRS\s*=.*${subdir}\b" "${path}"/Makefile.am` ]]; then
							sed -e "/^SUBDIRS\s*=/s|$| ${subdir}|" \
								-i "${path}"/Makefile.am || die "failed to append ${subdir}"
						fi
					fi
					[[ "${path}" = . ]] && break
				done
			fi
		done
	fi

	eautoreconf
}

# @FUNCTION: virtuoso_src_configure
# @DESCRIPTION:
# Runs ./configure with common and user options specified via myconf variable
virtuoso_src_configure() {
	debug-print-function ${FUNCNAME} "$@"

	use amd64 && append-flags "-m64"

	# Override some variables to make tests work
	if [[ ${PN} != virtuoso-server ]]; then
		[[ ${EAPI} == 2 ]] && ! use prefix && EPREFIX=
		export ISQL=${EPREFIX}/usr/bin/isql-v
		export SERVER=${EPREFIX}/usr/bin/virtuoso-t
	fi

	# Version specific options
	case ${PV} in
		5.0.11)
			;;
		*)
			myconf+=" --without-internal-zlib"
			;;
	esac

	econf \
		--with-layout=gentoo \
		--localstatedir=${EPREFIX}/var \
		--enable-shared \
		--with-pthreads \
		${myconf}
}

# @FUNCTION: virtuoso_src_compile
# @DESCRIPTION
# Runs make for specified subdirs
virtuoso_src_compile() {
	debug-print-function ${FUNCNAME} "$@"

	base_src_compile
}

# @FUNCTION: virtuoso_src_install
# @DESCRIPTION:
# Default src_install
virtuoso_src_install() {
	debug-print-function ${FUNCNAME} "$@"

	base_src_install
}
