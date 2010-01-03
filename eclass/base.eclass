# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/base.eclass,v 1.38 2009/05/17 09:25:55 loki_val Exp $

# @ECLASS: base.eclass
# @MAINTAINER:
# Peter Alfredsen <loki_val@gentoo.org>
#
# Original author Dan Armak <danarmak@gentoo.org>
# @BLURB: The base eclass defines some default functions and variables.
# @DESCRIPTION:
# The base eclass defines some default functions and variables. Nearly
# everything else inherits from here.

inherit eutils

case "${EAPI:-0}" in
	2|3)
		EXPORT_FUNCTIONS src_unpack src_prepare src_configure src_compile src_install
		;;
	*)
		EXPORT_FUNCTIONS src_unpack src_compile src_install
		;;
esac

# @ECLASS-VARIABLE: DOCS
# @USAGE: DOCS=( "${S}/doc/document.txt" "${S}/doc/doc_folder/" )
# @DESCRIPTION:
# Array containing documents passed to dodoc command.

# @ECLASS-VARIABLE: HTML_DOCS
# @USAGE: HTML_DOCS=( "${S}/doc/document.html" "${S}/doc/html_folder/" )
# @DESCRIPTION:
# Array containing documents passed to dohtml command.

# @ECLASS-VARIABLE: PATCHES
# @USAGE: PATCHES=( "${FILESDIR}/mypatch.patch" "${FILESDIR}/patches_folder/" )
# @DESCRIPTION:
# PATCHES array variable containing all various patches to be applied.
# This variable is expected to be defined in global scope of ebuild.
# Make sure to specify the full path. This variable is utilised in
# src_unpack/src_prepare phase based on EAPI.
# NOTE: if using patches folders with special file suffixes you have to
# define one additional variable EPATCH_SUFFIX="something"


# @FUNCTION: base_src_unpack
# @USAGE: [ unpack ] [ autopatch ] [ all ]
# @DESCRIPTION:
# The base src_unpack function, which is exported. If no argument is given,
# "all" is assumed if EAPI!=2, "unpack" if EAPI=2.
base_src_unpack() {
	debug-print-function $FUNCNAME "$@"

	if [[ -z "$1" ]]; then
		case "${EAPI:-0}" in
			2)
				base_src_util unpack
				;;
			*)
				base_src_util all
				;;
		esac
	else
		base_src_util $@
	fi
}

# @FUNCTION: base_src_prepare
# @DESCRIPTION:
# The base src_prepare function, which is exported when EAPI=2. Performs
# "base_src_util autopatch".
base_src_prepare() {
	debug-print-function $FUNCNAME "$@"

	base_src_util autopatch
}

# @FUNCTION: base_src_util
# @USAGE: [ unpack ] [ autopatch ] [ all ]
# @DESCRIPTION:
# The base_src_util function is the grunt function for base src_unpack
# and base src_prepare.
base_src_util() {
	debug-print-function $FUNCNAME "$@"

	local x oldval

	while [[ "$1" ]]; do
		case $1 in
			unpack)
				debug-print-section unpack

				pushd "${WORKDIR}" > /dev/null
				[[ ! -z "${A}" ]] && unpack ${A}
				popd > /dev/null
				;;
			autopatch)
				debug-print-section autopatch
				debug-print "$FUNCNAME: autopatch: PATCHES=$PATCHES"

				pushd "${S}" > /dev/null

				if declare -p PATCHES >/dev/null 2>&1 && declare -p PATCHES | grep -q '^declare -a '; then
					for x in "${PATCHES[@]}"; do
						debug-print "$FUNCNAME: autopatch: applying patch from ${x}"
						[[ -f "${x}" ]] && epatch "${x}"
						if [[ -d "${x}" ]]; then
							# Use standardized names and locations with bulk patching
							# Patch directory is ${WORKDIR}/patch
							# See epatch() in eutils.eclass for more documentation
							EPATCH_SUFFIX=${EPATCH_SUFFIX:=patch}

							# in order to preserve normal EPATCH_SOURCE value that can
							# be used other way than with base eclass store in local
							# variable and restore later
							oldval=${EPATCH_SOURCE}
							EPATCH_SOURCE=${x}
							epatch
							EPATCH_SOURCE=${oldval}
						fi
					done
				else
					for x in ${PATCHES}; do
						debug-print "$FUNCNAME: autopatch: patching from ${x}"
						epatch "${x}"
					done
				fi

				popd > /dev/null
				;;
			all)
				debug-print-section all
				base_src_util unpack autopatch
				;;
			esac

		shift
	done
}

# @FUNCTION: base_src_configure
# @DESCRIPTION:
# The base src_prepare function, which is exported when EAPI=2. Performs
# "base_src_work configure".
base_src_configure() {
	debug-print-function $FUNCNAME "$@"

	base_src_work configure
}

# @FUNCTION: base_src_compile
# @USAGE: [ configure ] [ make ] [ all ]
# @DESCRIPTION:
# The base src_compile function, which is exported. If no argument is given,
# "all" is assumed if EAPI!=2, "make" if EAPI=2.
base_src_compile() {
	debug-print-function $FUNCNAME "$@"

	if [[ -z "$1" ]]; then
		case "${EAPI:-0}" in
			2)
				base_src_work make
				;;
			*)
				base_src_work all
				;;
		esac
	else
		base_src_work $@
	fi
}

# @FUNCTION: base_src_work
# @USAGE: [ configure ] [ make ] [ all ]
# @DESCRIPTION:
# The base_src_work function is the grunt function for base src_configure
# and base src_compile.
base_src_work() {
	debug-print-function $FUNCNAME "$@"

	pushd "${S}" > /dev/null

	while [[ "$1" ]]; do
		case $1 in
			configure)
				debug-print-section configure
				if [[ -x ${ECONF_SOURCE:-.}/configure ]]; then
					econf || die "died running econf, $FUNCNAME:configure"
				fi
				;;
			make)
				debug-print-section make
				if [[ -f Makefile || -f GNUmakefile || -f makefile ]]; then
					emake || die "died running emake, $FUNCNAME:make"
				fi
				;;
			all)
				debug-print-section all
				base_src_work configure make
				;;
		esac

		shift
	done

	popd > /dev/null
}

# @FUNCTION: base_src_install
# @USAGE: [ make ] [ docs ] [ all ]
# @DESCRIPTION:
# The base src_install function, which is exported. If no argument is given,
# "all" is assumed.
base_src_install() {
	debug-print-function $FUNCNAME "$@"

	local x
	[[ -z "$1" ]] && base_src_install all

	pushd "${S}" > /dev/null

	while [[ "$1" ]]; do
		case $1 in
			make)
				debug-print-section make
				emake DESTDIR="${D}" install || die "died running make install, $FUNCNAME:make"
				;;
			docs)
				debug-print-section docs
				if declare -p DOCS >/dev/null 2>&1 && declare -p DOCS | grep -q '^declare -a '; then
					for x in "${DOCS[@]}"; do
						debug-print "$FUNCNAME: docs: creating document from ${x}"
						dodoc -r "${x}" || die "dodoc failed"
					done
				fi
				if declare -p HTML_DOCS >/dev/null 2>&1 && declare -p HTML_DOCS | grep -q '^declare -a '; then
					for x in "${HTML_DOCS[@]}"; do
						debug-print "$FUNCNAME: docs: creating html document from ${x}"
						dohtml -r "${x}" || die "dohtml failed"
					done
				fi
				;;
			all)
				debug-print-section all
				base_src_install make docs
				;;
		esac

		shift
	done

	popd > /dev/null
}
