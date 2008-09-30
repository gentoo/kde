# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kde4-meta.eclass,v 1.5 2008/03/13 17:57:51 ingmar Exp $
#
# @ECLASS: kde4-meta.eclass
# @MAINTAINER:
# kde@gentoo.org
# @BLURB: Eclass for writing "split" KDE packages.
# @DESCRIPTION:
# This eclass provides all necessary functions for writing split KDE ebuilds.
#
# You must define KMNAME to use this eclass, and do so before inheriting it. All other variables are optional.
# Do not include the same item in more than one of KMMODULE, KMMEXTRA, KMCOMPILEONLY, KMEXTRACTONLY.
#
# NOTE: This eclass uses the SLOT dependencies from EAPI="1" or compatible,
# hence you must define EAPI="1" in the ebuild, before inheriting any eclasses.

inherit multilib kde4-functions kde4-base

case "${EAPI}" in
	2)
		EXPORT_FUNCTIONS pkg_setup src_unpack src_configure src_compile src_test src_install pkg_postinst pkg_postrm
		;;
	*)
		EXPORT_FUNCTIONS pkg_setup src_unpack src_compile src_test src_install pkg_postinst pkg_postrm
		;;
esac

if [[ -z ${KMNAME} ]]; then
	die "kde4-meta.eclass inherited but KMNAME not defined - broken ebuild"
fi

case ${KDEBASE} in
	kde-base)	HOMEPAGE="http://www.kde.org/"
				LICENSE="GPL-2" ;;
	koffice)	HOMEPAGE="http://www.koffice.org/"
				LICENSE="GPL-2" ;;
esac

debug-print "${BASH_SOURCE} ${LINENO} ${ECLASS}: DEPEND ${DEPEND} - before blockers"
debug-print "${BASH_SOURCE} ${LINENO} ${ECLASS}: RDEPEND ${RDEPEND} - before blockers"

# Add a blocker on the package we're derived from
if [[ -n ${KDEBASE} ]]; then
	DEPEND="${DEPEND} !$(get-parent-package ${CATEGORY}/${PN}):${SLOT}"
	RDEPEND="${RDEPEND} !$(get-parent-package ${CATEGORY}/${PN}):${SLOT}"
fi

debug-print "line ${LINENO} ${ECLASS}: DEPEND ${DEPEND} - after blockers"
debug-print "line ${LINENO} ${ECLASS}: RDEPEND ${RDEPEND} - after blockers"

# Add dependencies that all packages in a certain module share.
case ${KMNAME} in
	kdebase|kdebase-workspace|kdebase-runtime)
		DEPEND="${DEPEND} >=kde-base/qimageblitz-0.0.4"
		RDEPEND="${RDEPEND} >=kde-base/qimageblitz-0.0.4"
	;;
	kdepim)
		DEPEND="${DEPEND} dev-libs/boost app-office/akonadi-server"
		RDEPEND="${RDEPEND} dev-libs/boost"
		if [[ ${PN} != kode ]]; then
			DEPEND="${DEPEND} >=kde-base/kode-${PV}:${SLOT}"
			RDEPEND="${RDEPEND} >=kde-base/kode-${PV}:${SLOT}"
		fi
		case ${PN} in
			akregator|kaddressbook|kjots|kmail|kmobiletools|knode|knotes|korganizer|ktimetracker)
				IUSE="+kontact"
				DEPEND="${DEPEND} kontact? ( >=kde-base/kontactinterfaces-${PV}:${SLOT} )"
				RDEPEND="${RDEPEND} kontact? ( >=kde-base/kontactinterfaces-${PV}:${SLOT} )"
			;;
		esac
	;;
	kdegames)
		if [[ ${PN} != "libkdegames" ]]; then
			DEPEND="${DEPEND} >=kde-base/libkdegames-${PV}:${SLOT}"
			RDEPEND="${RDEPEND} >=kde-base/libkdegames-${PV}:${SLOT}"
		fi
	;;
	koffice)
		case ${PN} in
			koffice-libs|koffice-data) : ;;
			*)
			DEPEND="${DEPEND} >=app-office/koffice-libs-${PV}:${SLOT}"
			RDEPEND="${RDEPEND} >=app-office/koffice-libs-${PV}:${SLOT}"
			;;
		esac
	;;
esac

debug-print "line ${LINENO} ${ECLASS}: DEPEND ${DEPEND} - after metapackage-specific dependencies"
debug-print "line ${LINENO} ${ECLASS}: RDEPEND ${RDEPEND} - after metapackage-specific dependencies"

# @ECLASS-VARIABLE: KMNAME
# @DESCRIPTION:
# Name of the parent-module (e.g. kdebase, kdepim, ...). You _must_ set it _before_ inheriting this eclass,
# (unlike the other parameters), since it's used to set $SRC_URI.

# @ECLASS-VARIABLE: KMMODULE
# @DESCRIPTION:
# Specify exactly one subdirectory of $KMNAME here. Defaults to $PN.
# The subdirectory listed here is treated exactly like items in $KMEXTRA.
#
# Example: The ebuild name of "kdebase/l10n" is kde-base/kdebase-l10n, because
# just 'l10n' would be too confusing. Hence it sets KMMODULE="l10n".

# @ECLASS-VARIABLE: KMNOMODULE
# @DESCRIPTION:
# If set to "true", $KMMODULE doesn't have to be defined.
#
# Example usage: If you're installing subdirectories of a package, like plugins,
# you mark the topsubdirectory (containing the package) as $KMEXTRACTONLY, and set KMNOMODULE="true".
if [[ ${KMNOMODULE} != "true" && -z ${KMMODULE} ]]; then
	KMMODULE=${PN}
fi

# @ECLASS-VARIABLE: KMEXTRA
# @DESCRIPTION:
# All subdirectories listed here will be extracted, compiled & installed.
# $KMMODULE is always added to $KMEXTRA.
# If the htmlhandbook USE-flag is set, and if this directory exists,
# then "doc/$KMMODULE" is added to $KMEXTRA. In other cases, this should be
# handled in the ebuild.
# If the documentation is in a different subdirectory, you should add it to KMEXTRA.

# @ECLASS-VARIABLE: KMCOMPILEONLY
# @DESCRIPTION:
# All subdirectories listed here will be extracted & compiled, but not installed.

# @ECLASS-VARIABLE: KMEXTRACTONLY
# @DESCRIPTION:
# All subdirectories listed here will be extracted, but not compiled nor installed.
# This can be used to avoid compilation in a subdirectory of a directory in $KMMODULE or $KMEXTRA

# @ECLASS-VARIABLE: KMTARPARAMS
# @DESCRIPTION:
# Specify extra parameters to pass to tar, in kde4-meta_src_extract.
# '-xpf -j' are passed to tar by default.

# @FUNCTION: kde4-meta_pkg_setup
# @DESCRIPTION:
# Currently just calls its equivalent in kde4-base.eclass(5). Use this in split
# ebuilds.
kde4-meta_pkg_setup() {
	kde4-base_pkg_setup
}

# @FUNCTION: kde4-meta_src_unpack
# @DESCRIPTION:
# This function unpacks the source for split ebuilds. See also
# kde4-meta-src_extract.
kde4-meta_src_unpack() {
	debug-print-function  ${FUNCNAME} "$@"

	kde4-meta_src_extract
	kde4-meta_change_cmakelists
}

# @FUNCTION: kde4-meta_src_extract
# @DESCRIPTION:
# A function to unpack the source for a split KDE ebuild.
# Also see KMMODULE, KMNOMODULE, KMEXTRA, KMCOMPILEONLY, KMEXTRACTONLY and KMTARPARAMS.
kde4-meta_src_extract() {
	local abort tarball tarfile f extractlist
	tarball="${KMNAME}-${PV}.tar.bz2"
	tarfile="${DISTDIR}"/${tarball}

	echo "Unpacking parts of ${tarball} to ${WORKDIR}"

	kde4-meta_create_extractlists

	for f in cmake/ CMakeLists.txt ConfigureChecks.cmake config.h.cmake \
		AUTHORS COPYING INSTALL README NEWS ChangeLog
	do
		extractlist="${extractlist} ${KMNAME}-${PV}/${f}"
	done
	extractlist="${extractlist} $(__list_needed_subdirectories)"
	KMTARPARAMS="${KMTARPARAMS} -j"

	pushd "${WORKDIR}" > /dev/null
	[[ -n ${KDE4_STRICTER} ]] && echo tar -xpf $tarfile $KMTARPARAMS $extractlist >&2
	tar -xpf $tarfile $KMTARPARAMS $extractlist 2> /dev/null

	# Default $S is based on $P; rename the extracted directory to match $S
	mv ${KMNAME}-${PV} ${P} || die "Died while moving \"${KMNAME}-${PV}\" to \"${P}\""

	popd > /dev/null

	if [[ -n ${KDE4_STRICTER} ]]; then
		for f in $(__list_needed_subdirectories fatal); do
			if [[ ! -e ${S}/${f#*/} ]]; then
				eerror "'${f#*/}' is missing"
				abort=true
			fi
		done
		[[ -n ${abort} ]] && die "There were missing files."
	fi

	kde4-base_src_unpack
}

# Create lists of files and subdirectories to extract.
# Also see the descriptions of KMMODULE, KMNOMODULE, KMEXTRA, KMCOMPILEONLY, KMEXTRACTONLY and KMTARPARAMS.
kde4-meta_create_extractlists() {
	debug-print-function ${FUNCNAME} "$@"

	if has htmlhandbook ${IUSE//+} && use htmlhandbook; then
		# We use the basename of $KMMODULE because $KMMODULE can contain
		# the path to the module subdirectory.
		KMEXTRA_NONFATAL="${KMEXTRA_NONFATAL} doc/${KMMODULE##*/}"
	fi

	# Add some CMake-files to KMEXTRACTONLY.
	# Note that this actually doesn't include KMEXTRA handling.
	# In those cases you should care to add the relevant files to KMEXTRACTONLY
	case ${KMNAME} in
		kdebase)
		KMEXTRACTONLY="${KMEXTRACTONLY}
			apps/config-apps.h.cmake
			apps/ConfigureChecks.cmake"
		;;
		kdebase-runtime)
		KMEXTRACTONLY="${KMEXTRACTONLY}
			config-runtime.h.cmake"
		;;
		kdebase-workspace)
		KMEXTRACTONLY="${KMEXTRACTONLY}
			config-unix.h.cmake
			ConfigureChecks.cmake
			config-workspace.h.cmake
			config-X11.h.cmake
			startkde.cmake"
		;;
		kdegames)
		if [[ ${PN} != "libkdegames" ]]; then
			KMEXTRACTONLY="${KMEXTRACTONLY}
				libkdegames"
		fi
		;;
		kdepim)
		KMEXTRACTONLY="${KMEXTRACTONLY}
			kleopatra/ConfigureChecks.cmake"
		if has kontact ${IUSE//+} && use kontact; then
			KMEXTRA="${KMEXTRA} kontact/plugins/${PLUGINNAME:-${PN}}"
			KMEXTRACTONLY="${KMEXTRACTONLY} kontactinterfaces/"
		fi
		;;
		koffice)
			KMEXTRACTONLY="${KMEXTRACTONLY}
				config-endian.h.cmake
				filters/config-filters.h.cmake
				config-openexr.h.cmake
				config-opengl.h.cmake
				config-prefix.h.cmake"
		;;
	esac
	# Don't install cmake modules for split ebuilds to avoid collisions.
	case ${KMNAME} in
		kdebase-runtime|kdebase-workspace|kdeedu|kdegames|kdegraphics|kdepim)
			case ${PN} in
				libkdegames|libkdeedu|marble)
					KMEXTRA="${KMEXTRA}
						cmake/modules/"
					;;

				*)
					KMCOMPILEONLY="${KMCOMPILEONLY}
						cmake/modules/"
					;;
			esac
		;;
	esac

	debug-print "line ${LINENO} ${ECLASS} ${FUNCNAME}: KMEXTRACTONLY ${KMEXTRACTONLY}"
}

__list_needed_subdirectories() {
	local i j kmextra kmextra_expanded kmmodule_expanded kmcompileonly_expanded extractlist topdir

	# We expand KMEXTRA by adding CMakeLists.txt files
	kmextra="${KMEXTRA}"
	[[ ${1} != fatal ]] && kmextra="${kmextra} ${KMEXTRA_NONFATAL}"
	for i in ${kmextra}; do
		kmextra_expanded="${kmextra_expanded} ${i}"
		j=$(dirname ${i})
		while [[ ${j} != "." ]]; do
			kmextra_expanded="${kmextra_expanded} ${j}/CMakeLists.txt";
			j=$(dirname ${j})
		done
	done

	# Expand KMMODULE
	if [[ -n ${KMMODULE}  ]]; then
		kmmodule_expanded="${KMMODULE}"
		j=$(dirname ${KMMODULE})
		while [[ ${j} != "." ]]; do
			kmmodule_expanded="${kmmodule_expanded} $j/CMakeLists.txt";
			j=$(dirname $j)
		done
	fi

	# Expand KMCOMPILEONLY
	for i in ${KMCOMPILEONLY}; do
		kmcompileonly_expanded="${kmcompileonly_expanded} ${i}"
		j=$(dirname ${i})
		while [[ ${j} != "." ]]; do
			kmcompileonly_expanded="${kmcompileonly_expanded} ${j}/CMakeLists.txt";
			j=$(dirname ${j})
		done
	done

	debug-print "line ${LINENO} ${ECLASS} ${FUNCNAME} - kmextra_expanded: ${kmextra_expanded}"
	debug-print "line ${LINENO} ${ECLASS} ${FUNCNAME} - kmmodule_expanded:  ${kmmodule_expanded}"
	debug-print "line ${LINENO} ${ECLASS} ${FUNCNAME} - kmcompileonly_expanded: ${kmcompileonly_expanded}"


	case ${PV} in
		scm|9999*) : ;;
		*) topdir="${KMNAME}-${PV}/" ;;
	esac

	# Create final list of stuff to extract
	for i in ${kmmodule_expanded} ${kmextra_expanded} ${kmcompileonly_expanded} \
		${KMEXTRACTONLY}
	do
		extractlist="${extractlist} ${topdir}${i}"
	done

	echo ${extractlist}
}

save_library_dependencies() {
	local depsfile="${T}/${PN}:${SLOT}"

	echo "Saving library dependendencies in ${depsfile##*/}"
	echo "EXPORT_LIBRARY_DEPENDENCIES(\"${depsfile}\")" >> "${S}/CMakeLists.txt" || \
		die "Failed to save the library dependencies."
}

install_library_dependencies() {
	local depsfile="${T}/${PN}:${SLOT}"
	echo "Installing library dependendencies as ${depsfile##*/}"
	insinto /var/lib/kde
	doins "${depsfile}" || die "Failed to install library dependencies."
}

load_library_dependencies() {
	local pn i depsfile
	echo "Injecting library dependendencies from '${KMLOADLIBS}'"

	i=0
	for pn in ${KMLOADLIBS} ; do
		((i++))
		depsfile="/var/lib/kde/${pn}:${SLOT}"
		[[ -r "${depsfile}" ]] || die "Depsfile '${depsfile}' not accessible. You probably need to reinstall ${pn}."
		sed -i -e "${i}iINCLUDE(\"${depsfile}\")" "${S}/CMakeLists.txt" || \
			die "Failed to include library dependencies for ${pn}"
	done
}

# @FUNCTION: kde4-meta_src_compile
# @DESCRIPTION:
# General function for compiling split KDE4 applications.
kde4-meta_src_compile() {
	debug-print-function  ${FUNCNAME} "$@"

	case "${EAPI}" in
		2 | 2_pre3 | 2_pre2 | 2_pre1)
		;;
		*)
			kde4-base_meta_configure
		;;
	esac
	kde4-meta_src_make
}

_change_cmakelists_parent_dirs() {
	debug-print-function ${FUNCNAME} "$@"

	local _olddir _dir
	_dir="${S}"/${1}
	until [[ ${_dir} == "${S}" ]]; do
		_olddir=$(basename "${_dir}")
		_dir=$(dirname "${_dir}")
		debug-print "${LINENO}: processing ${_dir} CMakeLists.txt searching for ${_olddir}"
		if [[ -f ${_dir}/CMakeLists.txt ]]; then
			sed -e "/add_subdirectory[[:space:]]*([[:space:]]*${_olddir}[[:space:]]*)/s/#DONOTCOMPILE //g" \
				-e "/ADD_SUBDIRECTORY[[:space:]]*([[:space:]]*${_olddir}[[:space:]]*)/s/#DONOTCOMPILE //g" \
				-i ${_dir}/CMakeLists.txt || die "${LINENO}: died in ${FUNCNAME} while processing ${_dir}"
		fi
	done
}

kde4-meta_change_cmakelists() {
	debug-print-function  ${FUNCNAME} "$@"

	pushd "${S}" > /dev/null

	if [[ -n ${KMSAVELIBS} ]] ; then
		save_library_dependencies
	fi

	if [[ -n ${KMLOADLIBS} ]] ; then
		load_library_dependencies
	fi

	comment_all_add_subdirectory ./

	# Restore "add_subdirectory( cmake )" in ${S}/CMakeLists.txt
	if [[ -f "${S}"/CMakeLists.txt ]]; then
		sed -e '/add_subdirectory[[:space:]]*([[:space:]]*cmake[[:space:]]*)/s/^#DONOTCOMPILE //' \
			-e '/ADD_SUBDIRECTORY[[:space:]]*([[:space:]]*cmake[[:space:]]*)/s/^#DONOTCOMPILE //' \
			-i "${S}"/CMakeLists.txt || die "${LINENO}: cmake sed died"
	fi

	if [[ -z ${KMNOMODULE} ]]; then
		# Restore "add_subdirectory" in $KMMODULE subdirectories
		find "${S}"/${KMMODULE} -name CMakeLists.txt -print0 | xargs -0 sed -i -e 's/^#DONOTCOMPILE //g' || \
			die "${LINENO}: died in KMMODULE section"
		_change_cmakelists_parent_dirs ${KMMODULE}
	fi

	# KMCOMPILEONLY
	local i
	for i in ${KMCOMPILEONLY}; do
		debug-print "${LINENO}: KMCOMPILEONLY, processing ${i}"
		# Uncomment "add_subdirectory" instructions inside $KMCOMPILEONLY, then comment "install" instructions.
		find "${S}"/${i} -name CMakeLists.txt -print0 | \
			xargs -0 sed -i \
				-e 's/^#DONOTCOMPILE //g' \
				-e '/install(.*)/{s/^/#DONOTINSTALL /;}' \
				-e '/^install(/,/)/{s/^/#DONOTINSTALL /;}' \
				-e '/kde4_install_icons(.*)/{s/^/#DONOTINSTALL /;}' || \
				die "${LINENO}: sed died in the KMCOMPILEONLY section while processing ${i}"
		_change_cmakelists_parent_dirs ${i}
	done

	# KMEXTRA section
	for i in ${KMEXTRA}; do
		debug-print "${LINENO}: KMEXTRA section, processing ${i}"
		find "${S}"/${i} -name CMakeLists.txt -print0 | \
			xargs -0 sed -i -e 's/^#DONOTCOMPILE //g' || \
			die "${LINENO}: sed died uncommenting add_subdirectory instructions in KMEXTRA section while processing ${i}"
		_change_cmakelists_parent_dirs ${i}
	done
	# KMEXTRA_NONFATAL section
	for i in ${KMEXTRA_NONFATAL}; do
		if [[ -d "${S}"/${i} ]]; then
			find "${S}"/${i} -name CMakeLists.txt -print0 | \
				xargs -0 sed -i -e 's/^#DONOTCOMPILE //g' || \
				die "${LINENO}: sed died uncommenting add_subdirectory instructions in KMEXTRA section while processing ${i}"
			_change_cmakelists_parent_dirs ${i}
		fi
	done

	# KMEXTRACTONLY section - Some ebuilds need to comment out some subdirs in KMMODULE and they use KMEXTRACTONLY
	for i in ${KMEXTRACTONLY}; do
		if [[ -d "${S}"/${i} && -f "${S}"/${i}/../CMakeLists.txt ]]; then
			sed -i -e "/([[:space:]]*$(basename $i)[[:space:]]*)/s/^/#DONOTCOMPILE /" "${S}"/${i}/../CMakeLists.txt || \
				die "${LINENO}: sed died while working in the KMEXTRACTONLY section while processing ${i}"
		fi
	done

	case ${KMNAME} in
		kdebase-workspace)
		# COLLISION PROTECT section
		# Only install the startkde script as part of kde-base/kdebase-startkde,
		# instead of with every package.
		if [[ ${PN} != "kdebase-startkde" && -f "${S}"/CMakeLists.txt ]]; then
			case ${PV} in
				*) # The startkde script moved to kdebase-workspace for KDE4 versions > 3.93.0.
				sed -i -e '/startkde/s/^/#DONOTINSTALL /' "${S}"/CMakeLists.txt || \
					die "${LINENO}: sed died in the kdebase-startkde collision prevention section"
				;;
			esac
		fi
		;;
		kdebase-runtime)
		# COLLISION PROTECT section
		# Only install the kde4 script as part of kde-base/kdebase-data
		if [[ ${PN} != "kdebase-data" && -f "${S}"/CMakeLists.txt ]]; then
			sed -i -e '/^install(PROGRAMS[[:space:]]*[^[:space:]]*\/kde4[[:space:]]/s/^/#DONOTINSTALL /' \
				"${S}"/CMakeLists.txt || die "Sed to exclude bin/kde4 failed"
		fi
		;;
		kdepim)
		case ${PN} in
			kaddressbook|kalarm|kmailcvt|kontact|korganizer|korn)
			sed -i -n -e '/qt4_generate_dbus_interface(.*org\.kde\.kmail\.\(kmail\|mailcomposer\)\.xml/p' \
				-e '/add_custom_target(kmail_xml /,/)/p' "${S}"/kmail/CMakeLists.txt || die "uncommenting xml failed"
			_change_cmakelists_parent_dirs kmail
			;;
		esac
		;;
		kdeutils)
		# This is sort of a hack to avoid patching 16 kdeutils packages with
		# r775410 from upstream trunk which makes blitz optional so superkaramba
		# only gets compiled when it is found. Bug #209324. Remove this no later
		# than 4.1.
		if [[ ${PN} != superkaramba && ${SLOT} == kde-4 ]]; then
			sed -i -e '/find_package(Blitz REQUIRED)/d' "${S}"/CMakeLists.txt \
				|| die "${LINENO}: sed to remove dependency on Blitz failed."
		fi
		;;
		koffice)
		if [[ ${PN} != koffice-libs ]]; then
			sed -i -e '/^INSTALL(FILES.*koffice.desktop/ s/^/#DONOTINSTALL /' \
				doc/CMakeLists.txt || \
				die "${LINENO}: sed died in the koffice.desktop collision prevention section"
		fi
		;;
	esac

	popd > /dev/null
}

# @FUNCTION: kde4-meta_src_configure
# @DESCRIPTION:
# Currently just calls its equivalent in kde4-base.eclass(5). Use this in split
# ebuilds.
kde4-meta_src_configure() {
	debug-print-function  ${FUNCNAME} "$@"

	kde4-base_src_configure
}

# @FUNCTION: kde4-meta_src_make
# @DESCRIPTION:
# Currently just calls its equivalent in kde4-base.eclass(5). Use this in split
# ebuilds.
kde4-meta_src_make() {
	debug-print-function  ${FUNCNAME} "$@"

	kde4-base_src_make
}

# @FUNCTION: kde4-meta_src_test
# @DESCRIPTION:
# Currently just calls its equivalent in kde4-base.eclass(5). Use this in split
# ebuilds.
kde4-meta_src_test() {
	debug-print-function $FUNCNAME "$@"

	kde4-base_src_test
}

# @FUNCTION: kde4-meta_src_install
# @DESCRIPTION:
# Function for installing KDE4 split applications.
kde4-meta_src_install() {
	debug-print-function $FUNCNAME "$@"

	kde4-meta_src_make_doc
	cmake-utils_src_install

	if [[ -n ${KMSAVELIBS} ]] ; then
		install_library_dependencies
	fi
}

# @FUNCTION: kde4-meta_src_make_doc
# @DESCRIPTION:
# This function searches under ${S}/${KMMODULE},
# and tries to install "AUTHORS ChangeLog* README* NEWS todo" if these files exist.
kde4-meta_src_make_doc() {
	debug-print-function  $FUNCNAME "$@"

	local doc
	for doc in AUTHORS ChangeLog* README* NEWS TODO; do
		[[ -s ${KMMODULE}/$doc ]] && newdoc "${KMMODULE}/${doc}" "${doc}.${KMMODULE##*/}"
	done

	kde4-base_src_make_doc
}

# @FUNCTION: kde4-meta_pkg_postinst
# @DESCRIPTION:
# Currently just calls its equivalent in kde4-base.eclass(5). Use this in split
# ebuilds.
kde4-meta_pkg_postinst() {
	kde4-base_pkg_postinst
}

# @FUNCTION: kde4-meta_pkg_postrm
# @DESCRIPTION:
# Currently just calls its equivalent in kde4-base.eclass(5). Use this in split
# ebuilds.
kde4-meta_pkg_postrm() {
	kde4-base_pkg_postrm
}
