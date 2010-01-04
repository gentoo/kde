# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/base.eclass,v 1.38 2009/05/17 09:25:55 loki_val Exp $

# @ECLASS: base.eclass
# @MAINTAINER:
# QA Team <qa@gentoo.org>
#
# Original author Dan Armak <danarmak@gentoo.org>
# @BLURB: The base eclass defines some default functions and variables.
# @DESCRIPTION:
# The base eclass defines some default functions and variables. Nearly
# everything else inherits from here.

inherit eutils

BASE_EXPF="src_unpack src_compile src_install"
case "${EAPI:-0}" in
	2|3|4) BASE_EXPF="src_prepare src_configure" ;;
	*) ;;
esac

EXPORT_FUNCTIONS ${BASE_EXPF}

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
# @DESCRIPTION:
# The base src_unpack function, which is exported.
# Calls also src_prepare with eapi older than 2.
base_src_unpack() {
	debug-print-function $FUNCNAME "$@"

	pushd "${WORKDIR}" > /dev/null

	[[ -n "${A}" ]] && unpack ${A}
	has src_prepare ${BASE_EXPF} || base_src_prepare

	popd > /dev/null
}

# @FUNCTION: base_src_prepare
# @DESCRIPTION:
# The base src_prepare function, which is exported
# EAPI is greater or equal to 2.
base_src_prepare() {
	debug-print-function $FUNCNAME "$@"
	debug-print "$FUNCNAME: PATCHES=$PATCHES"

	pushd "${S}" > /dev/null
	if [[ "$(declare -p PATCHES 2>/dev/null 2>&1)" == "declare -a"* ]]; then
		for x in "${PATCHES[@]}"; do
			debug-print "$FUNCNAME: applying patch from ${x}"
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
			debug-print "$FUNCNAME: patching from ${x}"
			epatch "${x}"
		done
	fi

	# Apply user patches
	debug-print "$FUNCNAME: applying user patches"
	epatch_user

	popd > /dev/null
}

# @FUNCTION: base_src_configure
# @DESCRIPTION:
# The base src_configure function, which is exported when
# EAPI is greater or equal to 2. Runs basic econf.
base_src_configure() {
	debug-print-function $FUNCNAME "$@"

	# there is no pushd ${S} so we can override its place where to run
	[[ -x ${ECONF_SOURCE:-.}/configure ]] && econf
}

# @FUNCTION: base_src_compile
# @DESCRIPTION:
# The base src_compile function, calls src_configure with
# EAPI older than 2.
base_src_compile() {
	debug-print-function $FUNCNAME "$@"

	has src_configure ${BASE_EXPF} || base_src_configure
	base_src_make
}

# @FUNCTION: base_src_make
# @DESCRIPTION:
# Actual function that runs emake command.
base_src_make() {
	debug-print-function $FUNCNAME "$@"

	if [[ -f Makefile || -f GNUmakefile || -f makefile ]]; then
		emake || die "died running emake, $FUNCNAME:make"
	fi
}

# @FUNCTION: base_src_install
# @DESCRIPTION:
# The base src_install function. Runs make install and
# installs documents and html documents from DOCS and HTML_DOCS
# arrays.
base_src_install() {
	debug-print-function $FUNCNAME "$@"

	emake DESTDIR="${D}" install || die "died running make install, $FUNCNAME:make"
	base_src_install_docs
}

# @FUNCTION: base_src_install_docs
# @DESCRIPTION:
# Actual function that install documentation from
# DOCS and HTML_DOCS arrays.
base_src_install_docs() {
	debug-print-function $FUNCNAME "$@"

	local x

	pushd "${S}" > /dev/null

	if [[ "$(declare -p DOCS 2>/dev/null 2>&1)" == "declare -a"* ]]; then
		for x in "${DOCS[@]}"; do
			debug-print "$FUNCNAME: docs: creating document from ${x}"
			dodoc -r "${x}" || die "dodoc failed"
		done
	fi
	if [[ "$(declare -p HTML_DOCS 2>/dev/null 2>&1)" == "declare -a"* ]]; then
		for x in "${HTML_DOCS[@]}"; do
			debug-print "$FUNCNAME: docs: creating html document from ${x}"
			dohtml -r "${x}" || die "dohtml failed"
		done
	fi

	popd > /dev/null
}
